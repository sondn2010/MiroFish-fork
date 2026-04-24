# System Architecture — Sardines

## High-Level Overview

Sardines is a distributed web application consisting of a Vue 3 frontend SPA, a Flask REST API backend, and supporting services for graph management, simulation, and LLM-powered reporting.

```
┌─────────────────────────────────────────────────────────────────┐
│                      User Browser (Vue 3 SPA)                   │
│  ┌──────────────┐  ┌─────────────┐  ┌─────────────────────────┐ │
│  │ Graph Panel  │  │ Simulation  │  │ Report Generation UI    │ │
│  │ D3 Vis       │  │ Configuration│  │ Interactive Results     │ │
│  └──────────────┘  └─────────────┘  └─────────────────────────┘ │
│                          │                                       │
│                          │ Axios HTTP                            │
└──────────────────────────┼───────────────────────────────────────┘
                           │
                           ↓
┌─────────────────────────────────────────────────────────────────┐
│              Flask REST API (Backend)                            │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────┐   │
│  │ Graph Routes │  │ Simulation   │  │ Report Routes        │   │
│  │ /api/graphs  │  │ /api/sims    │  │ /api/reports         │   │
│  └──────────────┘  └──────────────┘  └──────────────────────┘   │
│                          │                                       │
└──────┬───────────────────┼───────────────────────┬───────────────┘
       │                   │                       │
       ↓                   ↓                       ↓
┌─────────────────┐ ┌──────────────────┐ ┌─────────────────────┐
│  PostgreSQL DB  │ │ Simulation      │ │ Claude API          │
│ (graphs,        │ │ Runner (IPC)    │ │ (Report Generation) │
│  simulations)   │ │ Parallel jobs   │ │                     │
└─────────────────┘ └──────────────────┘ └─────────────────────┘
                               │
                               ↓
                    ┌──────────────────────┐
                    │ Graph Providers      │
                    │ - Graphiti (local)   │
                    │ - Zep Cloud (remote) │
                    └──────────────────────┘
```

---

## Architectural Layers

### 1. Presentation Layer (Frontend)

**Technology:** Vue 3 + Vite + D3.js

**Responsibility:**
- Render interactive UI for graph building, simulation control, and analysis
- Handle user input and validation
- Visualize graphs and simulation results
- Manage client-side state (temporary data, UI state)
- Call backend APIs via HTTP

**Key Components:**
- `Home.vue` — Landing page
- `Process.vue` — Multi-step workflow orchestrator
- `GraphPanel.vue` — D3-based graph visualization
- `SimulationView.vue` — Parameter configuration
- `SimulationRunView.vue` — Real-time simulation monitoring
- `ReportView.vue` — Results display and analysis
- `LanguageSwitcher.vue` — Locale switching

**State Management:**
- Vue Composition API for component state
- Pinia-like patterns for shared state (pendingUpload.js)
- i18n for localization state

**Design System:**
- Material Design 3 tokens (design-tokens.css)
- No hardcoded colors, fonts, or spacing
- Glassmorphism for floating elements
- Gradient CTAs and hero sections

---

### 2. API Layer (Backend Routes)

**Technology:** Flask Blueprints

**Responsibility:**
- Define REST API endpoints
- Handle HTTP requests and responses
- Validate input data
- Coordinate service layer calls
- Return standardized JSON responses

**API Endpoints:**

#### Graph Management (`/api/v1/graphs`)
```
POST   /api/v1/graphs                 # Create graph
GET    /api/v1/graphs                 # List graphs
GET    /api/v1/graphs/{id}            # Get graph details
PUT    /api/v1/graphs/{id}            # Update graph
DELETE /api/v1/graphs/{id}            # Delete graph
POST   /api/v1/graphs/{id}/visualize  # Get D3 visualization data
```

#### Simulation (`/api/v1/simulations`)
```
POST   /api/v1/simulations                    # Create simulation run
GET    /api/v1/simulations/{id}               # Get simulation status
GET    /api/v1/simulations/{id}/results       # Get simulation results
GET    /api/v1/simulations/{id}/logs          # Get step-by-step logs
DELETE /api/v1/simulations/{id}               # Cancel simulation
```

#### Report Generation (`/api/v1/reports`)
```
POST   /api/v1/reports                    # Generate report (sync/async)
GET    /api/v1/reports/{id}               # Get report
GET    /api/v1/reports/{id}/export        # Export as PDF/HTML/Markdown
```

**Response Format:**
```json
{
  "status": "success",
  "data": { /* payload */ },
  "meta": {
    "timestamp": "2026-04-24T12:00:00Z",
    "request_id": "req_abc123"
  }
}
```

**Error Format:**
```json
{
  "status": "error",
  "error": "Simulation not found",
  "code": "NOT_FOUND",
  "details": null
}
```

---

### 3. Service Layer (Business Logic)

**Technology:** Python classes with dependency injection

**Responsibility:**
- Implement core business logic
- Coordinate between models and providers
- Handle complex workflows
- Manage transactional consistency

**Key Services:**

#### GraphBuilder
- Constructs knowledge graphs from user input
- Validates graph structure (cycles, connectivity, etc.)
- Exports/imports graphs in standard formats

#### SimulationManager
- Orchestrates simulation workflow
- Manages simulation state and progress
- Coordinates with SimulationRunner via IPC

#### SimulationRunner
- Executes agent-based simulation
- Updates graph state at each time step
- Records step-by-step logs

#### ReportAgent
- Calls Claude API to generate narrative insights
- Analyzes simulation results
- Formats findings for export

#### OntologyGenerator
- Creates semantic ontologies from simulation results
- Normalizes entity references
- Extracts key insights

#### GraphProvider (Factory Pattern)
- Abstract interface for graph backend operations
- `GraphitiLocalProvider` — Local graph store
- `ZepCloudProvider` — Cloud-based memory graph

**Service Interaction Pattern:**
```python
class SimulationManager:
    def __init__(self, graph_service, runner_service, db):
        self.graph_service = graph_service
        self.runner_service = runner_service
        self.db = db
    
    def run_simulation(self, graph_id, config):
        # 1. Load graph from DB
        graph = self.graph_service.get(graph_id)
        
        # 2. Validate configuration
        if not self._validate_config(config):
            raise ValueError("Invalid config")
        
        # 3. Create simulation record
        sim = self.db.create_simulation(graph_id, config)
        
        # 4. Delegate to runner (async)
        self.runner_service.start(sim.id, graph, config)
        
        return sim
```

---

### 4. Data Access Layer (Models & ORM)

**Technology:** SQLAlchemy (ORM), PostgreSQL

**Responsibility:**
- Define data models
- Persist data to database
- Provide query interface

**Key Models:**

#### Project
```python
class Project:
    id: UUID
    name: str
    description: str
    created_at: datetime
    updated_at: datetime
    graphs: List[Graph]
```

#### Graph
```python
class Graph:
    id: UUID
    project_id: UUID
    name: str
    nodes: JSON  # [{"id": "1", "label": "Entity", ...}]
    edges: JSON  # [{"source": "1", "target": "2", "weight": 0.5}]
    created_at: datetime
    updated_at: datetime
```

#### SimulationRun
```python
class SimulationRun:
    id: UUID
    graph_id: UUID
    config: JSON
    status: enum (pending, running, completed, failed)
    results: JSON  # Opinion trajectories, statistics
    logs: JSON     # Step-by-step state transitions
    started_at: datetime
    completed_at: datetime
```

#### Report
```python
class Report:
    id: UUID
    simulation_id: UUID
    title: str
    content: str  # Markdown
    export_formats: JSON  # {pdf: URL, html: URL}
    generated_at: datetime
```

**Database Schema (Simplified):**
```sql
-- Projects
CREATE TABLE projects (
  id UUID PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  created_at TIMESTAMP
);

-- Graphs
CREATE TABLE graphs (
  id UUID PRIMARY KEY,
  project_id UUID REFERENCES projects(id),
  name VARCHAR(255),
  nodes JSONB,
  edges JSONB,
  created_at TIMESTAMP
);

-- Simulations
CREATE TABLE simulation_runs (
  id UUID PRIMARY KEY,
  graph_id UUID REFERENCES graphs(id),
  config JSONB,
  status VARCHAR(50),
  results JSONB,
  logs JSONB,
  started_at TIMESTAMP,
  completed_at TIMESTAMP
);

-- Reports
CREATE TABLE reports (
  id UUID PRIMARY KEY,
  simulation_id UUID REFERENCES simulation_runs(id),
  title VARCHAR(255),
  content TEXT,
  generated_at TIMESTAMP
);
```

---

### 5. External Integration Layer

**Responsibility:** Interface with third-party services

#### LLM Integration (Claude API)
```python
class LLMClient:
    def generate_report(self, simulation_results, graph_structure):
        prompt = self._build_prompt(simulation_results, graph_structure)
        response = anthropic.Anthropic().messages.create(
            model="claude-3-5-sonnet-20241022",
            max_tokens=2000,
            messages=[{"role": "user", "content": prompt}]
        )
        return response.content[0].text
```

#### Graph Provider Interface
```python
class GraphProvider(ABC):
    @abstractmethod
    def create_graph(self, nodes, edges) -> str:
        """Create graph, return ID."""
        pass
    
    @abstractmethod
    def query_neighbors(self, node_id) -> List[str]:
        """Get adjacent nodes."""
        pass
    
    @abstractmethod
    def update_state(self, node_id, opinion) -> None:
        """Update node state."""
        pass
```

#### Zep Integration
```python
class ZepCloudProvider(GraphProvider):
    def __init__(self, api_key):
        self.client = ZepClient(api_key=api_key)
    
    def create_graph(self, nodes, edges):
        # Store in Zep memory API
        pass
```

---

## Data Flow Diagrams

### User Creates and Runs a Simulation

```
1. User builds graph in UI (drag-drop nodes/edges)
   │
   ↓ Axios POST /api/v1/graphs
   
2. Backend receives graph JSON
   ├→ GraphBuilder.validate()
   ├→ GraphBuilder.store() → DB
   └→ Return graph ID
   
3. User configures simulation (opinion params, duration)
   │
   ↓ Axios POST /api/v1/simulations
   
4. Backend receives config
   ├→ SimulationManager.validate_config()
   ├→ Create SimulationRun record (status: pending)
   └→ Spawn SimulationRunner process (IPC)
   
5. SimulationRunner executes (background)
   ├→ Load graph from DB
   ├→ Initialize agent opinions
   ├→ Loop through time steps:
   │  ├→ Update node opinions (interaction rules)
   │  ├→ Record state snapshot
   │  └→ Check stopping conditions
   └→ Write final results to DB (status: completed)
   
6. Frontend polls /api/v1/simulations/{id} for progress
   ├→ UI updates progress bar
   └→ When complete, load results from /api/v1/simulations/{id}/results
   
7. User clicks "Generate Report"
   │
   ↓ Axios POST /api/v1/reports
   
8. Backend receives request
   ├→ Load simulation results
   ├→ Call Claude API with simulation data
   ├→ Claude generates narrative report
   ├→ Store Report record in DB
   └→ Return report ID
   
9. Frontend displays report (Markdown render)
   └→ User can export to PDF/HTML
```

---

## Concurrency & Parallelization

### Multi-Simulation Execution

**Problem:** Long-running simulations block other users

**Solution:** IPC-based simulation runner pool

```
API Request (POST /simulations)
    │
    ├─→ Store in DB (status: pending)
    └─→ Queue job to SimulationRunner pool
            │
            ├─→ Worker 1: Simulation A (steps 0-100)
            ├─→ Worker 2: Simulation B (steps 0-50)
            └─→ Worker 3: Idle, waiting

Frontend polls status endpoint for progress updates
    └─→ Returns: {status: running, progress: 50%, step: 50}
```

**Implementation:**
- IPC via pipes or shared memory
- SQLite or Redis queue for job management
- Graceful shutdown and recovery

---

## Scalability Considerations

### Current Architecture (Single-Server)
- **Bottleneck:** Simulation execution time (CPU-bound)
- **Limits:** ~10 concurrent 1000-node simulations on standard hardware

### Future Horizontal Scaling
1. **Simulation Distribution:**
   - Deploy SimulationRunner on separate compute nodes
   - Use job queue (Celery + Redis/RabbitMQ)
   - Distribute graph data via shared storage (S3 or NFS)

2. **Database:**
   - Read replicas for API queries
   - Write optimizations (indexing, partitioning)
   - Caching layer (Redis) for frequently accessed graphs

3. **Frontend:**
   - CDN for static assets
   - Load balancer for API requests
   - Connection pooling for WebSocket (real-time progress)

---

## Security Architecture

### Authentication & Authorization
```
Frontend
  ├─→ User provides credentials
  └─→ Backend issues JWT token
        │
        └─→ Token stored in localStorage (or httpOnly cookie)
             │
             ├─→ Include in every API request (Authorization header)
             └─→ Backend validates signature + expiration
                  │
                  └─→ If valid, proceed
                  └─→ If invalid, return 401
```

### Data Protection
- **In Transit:** HTTPS only
- **At Rest:** Sensitive data encrypted (DB-level or app-level)
- **Access Control:** User can only access their own projects/simulations

### Input Validation
```python
# Example: Validate graph structure
def validate_graph(graph_json):
    # 1. Check schema (nodes, edges required)
    # 2. Check constraints (no > 100k nodes)
    # 3. Sanitize strings (no HTML/JavaScript)
    # 4. Validate references (edges point to valid nodes)
    pass
```

---

## Deployment Architecture

### Development Environment
```
Local Machine
├─→ Frontend: npm run dev (Vite dev server on :5173)
├─→ Backend: python run.py (Flask on :5000)
└─→ Database: PostgreSQL (local or Docker)
```

### Production Environment
```
Docker Compose / Kubernetes
├─→ Frontend: Served by Nginx (static assets)
│   └─→ Build: npm run build → dist/
├─→ Backend: Flask via uWSGI/Gunicorn
│   ├─→ Multiple workers for concurrency
│   └─→ Health check endpoint
├─→ Database: PostgreSQL container/RDS
├─→ Redis: Optional (caching, job queue)
└─→ Monitoring: Prometheus + Grafana (optional)
```

---

## Error Handling & Recovery

### Frontend Error Handling
```javascript
async function fetchSimulation(id) {
  try {
    const response = await axios.get(`/api/v1/simulations/${id}`)
    return response.data
  } catch (error) {
    if (error.response?.status === 404) {
      throw new Error('Simulation not found')
    } else if (error.response?.status === 500) {
      console.error('Server error:', error)
      // Retry with exponential backoff
      return retryWithBackoff(() => fetchSimulation(id), 3)
    } else {
      throw error
    }
  }
}
```

### Backend Error Handling
```python
@graph_bp.route('/<graph_id>', methods=['GET'])
def get_graph(graph_id):
    try:
        graph = GraphService.get(graph_id)
        return jsonify(graph), 200
    except ValueError as e:
        logger.warning(f"Invalid graph_id: {graph_id}")
        return jsonify({'error': str(e)}), 400
    except DatabaseError as e:
        logger.error(f"Database error: {e}")
        return jsonify({'error': 'Service temporarily unavailable'}), 503
    except Exception as e:
        logger.exception(f"Unexpected error in get_graph")
        return jsonify({'error': 'Internal server error'}), 500
```

---

## Performance Optimization

### Frontend
- **Code Splitting:** Load route-specific code only when needed
- **Lazy Loading:** D3 visualizations rendered on demand
- **Memoization:** Cache expensive computed properties (graph layout)
- **Virtual Scrolling:** For large result lists (100+ items)

### Backend
- **Query Optimization:** Index frequently filtered columns (graph_id, status)
- **Pagination:** API returns max 100 results per page
- **Caching:** Redis cache for graph structures and config templates
- **Async I/O:** Non-blocking I/O for I/O-bound operations

### Database
```sql
-- Indexes on frequently queried columns
CREATE INDEX idx_graphs_project_id ON graphs(project_id);
CREATE INDEX idx_simulations_graph_id ON simulation_runs(graph_id);
CREATE INDEX idx_simulations_status ON simulation_runs(status);
```

---

## Monitoring & Observability

### Metrics to Track
- API response time (p50, p95, p99)
- Simulation execution time
- Error rate (5xx, 4xx)
- Database query time
- Frontend page load time
- Concurrent user count

### Logging Strategy
```python
import logging

logger = logging.getLogger(__name__)

# Log important events with context
logger.info(f"Simulation started", extra={
    'simulation_id': sim.id,
    'graph_size': len(graph['nodes']),
    'user_id': user_id
})

# Log errors with traceback
logger.exception(f"Simulation failed", extra={
    'simulation_id': sim.id,
    'error_code': error_code
})
```

### Tracing
- Unique request ID attached to all log entries
- Helps trace request flow through multiple services

---

## References

- **Design System:** `docs/DESIGN.md`, `docs/design-guidelines.md`
- **Code Standards:** `docs/code-standards.md`
- **Project Overview:** `docs/project-overview-pdr.md`

---

**Last Updated:** 2026-04-24
**Version:** 1.0
