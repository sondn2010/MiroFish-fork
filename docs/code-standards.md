# Code Standards & Project Structure

## Overview

This document defines coding standards, architectural patterns, and file organization for the Sardines project. All contributors must follow these standards to maintain consistency, readability, and maintainability.

---

## File & Folder Organization

### Frontend Structure

```
frontend/
├── src/
│   ├── api/                     # HTTP client modules
│   │   ├── graph.js             # Graph API endpoints
│   │   ├── simulation.js        # Simulation API endpoints
│   │   ├── report.js            # Report API endpoints
│   │   └── index.js             # Centralized export
│   │
│   ├── assets/                  # Static assets
│   │   └── logo/
│   │       └── sardines-logo.png
│   │
│   ├── components/              # Reusable Vue components
│   │   ├── GraphPanel.vue       # Graph visualization
│   │   ├── HistoryDatabase.vue  # Database history panel
│   │   ├── LanguageSwitcher.vue # i18n language selector
│   │   └── Step*.vue            # Workflow step components
│   │
│   ├── i18n/                    # Internationalization
│   │   └── index.js             # i18n configuration
│   │
│   ├── router/                  # Vue Router
│   │   └── index.js             # Route definitions
│   │
│   ├── store/                   # State management
│   │   └── pendingUpload.js     # Upload state module
│   │
│   ├── styles/                  # Global styles
│   │   └── design-tokens.css    # MD3 design tokens (source of truth)
│   │
│   ├── views/                   # Page components
│   │   ├── Home.vue             # Landing page
│   │   ├── MainView.vue         # Main workflow container
│   │   ├── Process.vue          # Multi-step workflow
│   │   ├── SimulationView.vue   # Simulation configuration
│   │   ├── SimulationRunView.vue # Real-time simulation
│   │   ├── ReportView.vue       # Report display
│   │   └── InteractionView.vue  # User interaction panel
│   │
│   ├── App.vue                  # Root component
│   └── main.js                  # Entry point
│
├── index.html                   # HTML template
├── package.json                 # Dependencies
├── vite.config.js              # Vite configuration
└── .gitignore
```

### Backend Structure

```
backend/
├── app/
│   ├── api/                     # Flask blueprints (routes)
│   │   ├── __init__.py          # Blueprint registration
│   │   ├── graph.py             # Graph API routes
│   │   ├── simulation.py        # Simulation API routes
│   │   └── report.py            # Report API routes
│   │
│   ├── models/                  # Data models & persistence
│   │   ├── __init__.py
│   │   ├── project.py           # Project context management
│   │   └── task.py              # Task tracking
│   │
│   ├── services/                # Business logic (core domain)
│   │   ├── __init__.py
│   │   ├── graph_builder.py     # Graph construction logic
│   │   ├── graph_provider/      # Multiple graph backends
│   │   │   ├── base.py
│   │   │   ├── factory.py
│   │   │   ├── graphiti_local_provider.py
│   │   │   └── zep_cloud_provider.py
│   │   ├── report_agent.py      # LLM report generation
│   │   ├── simulation_manager.py    # Simulation orchestration
│   │   ├── simulation_runner.py     # Simulation execution
│   │   ├── simulation_config_generator.py
│   │   ├── simulation_ipc.py        # IPC communication
│   │   ├── text_processor.py        # Text preprocessing
│   │   ├── ontology_generator.py    # Ontology creation
│   │   ├── oasis_profile_generator.py
│   │   ├── zep_entity_reader.py     # Zep integration
│   │   ├── zep_graph_memory_updater.py
│   │   └── zep_tools.py
│   │
│   ├── utils/                   # Utility functions
│   │   ├── __init__.py
│   │   ├── llm_client.py        # LLM API wrapper
│   │   ├── file_parser.py       # File I/O utilities
│   │   ├── locale.py            # Locale utilities
│   │   ├── logger.py            # Logging configuration
│   │   ├── ontology_normalizer.py
│   │   ├── retry.py             # Retry logic
│   │   └── zep_paging.py
│   │
│   └── config.py                # Configuration management
│
├── scripts/                     # CLI tools
│   ├── run_parallel_simulation.py
│   ├── run_reddit_simulation.py
│   ├── run_twitter_simulation.py
│   └── action_logger.py
│
├── tests/                       # Unit tests
│   └── test_ontology_normalizer.py
│
├── run.py                       # Flask app entry point
├── requirements.txt             # Python dependencies
├── pyproject.toml              # Project metadata
└── config.py
```

### Documentation Structure

```
docs/
├── DESIGN.md                    # Design system philosophy ("Digital Architect")
├── codebase-summary.md          # Technology stack & overview
├── design-guidelines.md         # MD3 token usage & patterns
├── project-overview-pdr.md      # Requirements & specifications
├── code-standards.md            # This file
├── system-architecture.md       # Architecture & data flow
├── development-roadmap.md       # Milestones & progress
└── project-changelog.md         # Detailed change history
```

---

## Naming Conventions

### JavaScript/Vue Files
- **Components:** PascalCase (e.g., `GraphPanel.vue`, `LanguageSwitcher.vue`)
- **Utilities:** camelCase (e.g., `llmClient.js`, `fileParser.js`)
- **Folders:** kebab-case for multi-word names (e.g., `graph-provider/`)

### Python Files
- **Modules:** snake_case (e.g., `graph_builder.py`, `llm_client.py`)
- **Classes:** PascalCase (e.g., `GraphBuilder`, `LLMClient`)
- **Functions:** snake_case (e.g., `create_graph()`, `process_text()`)
- **Constants:** UPPER_SNAKE_CASE (e.g., `MAX_AGENTS`, `DEFAULT_TIMEOUT`)

### CSS Classes & Tokens
- **Design Tokens:** --md-{category}-{variant} (e.g., `--md-primary`, `--md-surface-container-low`)
- **Utility Classes:** `.u-{purpose}` (e.g., `.u-flex-center`)
- **Component Classes:** `.c-{component-name}` (e.g., `.c-graph-panel`)

### Database & API
- **Table Names:** snake_case (e.g., `user_projects`, `simulation_runs`)
- **Columns:** snake_case (e.g., `created_at`, `graph_id`)
- **API Endpoints:** kebab-case paths (e.g., `/api/v1/graph-builds`, `/api/v1/simulation-runs`)

---

## Code Style Guidelines

### Vue 3 Components

**Structure:**
```vue
<template>
  <!-- Single root element, descriptive class names -->
  <div class="c-component-name">
    <!-- Template logic -->
  </div>
</template>

<script setup>
// 1. Imports (Vue, external, internal)
import { ref, computed, onMounted } from 'vue'
import { fetchData } from '@/api'

// 2. Props & Emits
const props = defineProps({
  dataSource: Array,
  title: String
})

const emit = defineEmits(['update', 'close'])

// 3. Reactive state
const isLoading = ref(false)
const items = ref([])

// 4. Computed properties
const filteredItems = computed(() => 
  items.value.filter(item => item.active)
)

// 5. Methods
const loadData = async () => {
  isLoading.value = true
  try {
    const data = await fetchData(props.dataSource)
    items.value = data
  } catch (error) {
    console.error('Failed to load:', error)
  } finally {
    isLoading.value = false
  }
}

// 6. Lifecycle hooks
onMounted(() => {
  loadData()
})
</script>

<style scoped>
/* Use design tokens for all values */
.c-component-name {
  padding: var(--space-3);
  background: var(--md-surface-container-low);
  color: var(--md-on-surface);
  border-radius: var(--round-lg);
  font: var(--type-body-md);
  box-shadow: var(--shadow-card);
}

.c-component-name__title {
  font: var(--type-headline-md);
  margin-bottom: var(--space-2);
}
</style>
```

### Python Services

**Structure:**
```python
"""
Brief module description.
Detailed explanation of responsibilities.
"""

import logging
from typing import Dict, List, Optional, Any
from dataclasses import dataclass

logger = logging.getLogger(__name__)

# Constants at top
DEFAULT_TIMEOUT = 30
MAX_AGENTS = 100_000


@dataclass
class GraphConfig:
    """Configuration for graph operations."""
    nodes: int
    edges: int
    directed: bool = True


class GraphBuilder:
    """Responsible for constructing and validating knowledge graphs."""
    
    def __init__(self, config: GraphConfig):
        self.config = config
        self._graph = None
    
    def build(self) -> Dict[str, Any]:
        """
        Build and return the graph structure.
        
        Returns:
            Dict containing graph nodes and edges.
            
        Raises:
            ValueError: If configuration is invalid.
        """
        if not self._validate_config():
            raise ValueError(f"Invalid config: {self.config}")
        
        self._graph = self._construct_graph()
        logger.info(f"Built graph with {self.config.nodes} nodes")
        return self._graph
    
    def _validate_config(self) -> bool:
        """Validate configuration parameters."""
        return (
            self.config.nodes > 0 and
            self.config.edges > 0 and
            self.config.edges <= self.config.nodes * (self.config.nodes - 1)
        )
    
    def _construct_graph(self) -> Dict[str, Any]:
        """Internal method to construct the graph."""
        # Implementation
        pass
```

### API Routes (Flask)

```python
"""
Graph API routes.
Handles graph creation, retrieval, and manipulation.
"""

from flask import Blueprint, request, jsonify
from app.services import GraphBuilder
from app.utils import logger

graph_bp = Blueprint('graph', __name__, url_prefix='/api/v1/graphs')


@graph_bp.route('', methods=['POST'])
def create_graph():
    """Create a new graph."""
    try:
        data = request.json
        builder = GraphBuilder(data)
        graph = builder.build()
        return jsonify({'id': graph['id'], 'status': 'created'}), 201
    except ValueError as e:
        logger.error(f"Invalid graph data: {e}")
        return jsonify({'error': str(e)}), 400
    except Exception as e:
        logger.exception("Unexpected error creating graph")
        return jsonify({'error': 'Internal server error'}), 500


@graph_bp.route('/<graph_id>', methods=['GET'])
def get_graph(graph_id):
    """Retrieve a graph by ID."""
    try:
        graph = GraphService.get(graph_id)
        return jsonify(graph), 200
    except KeyError:
        return jsonify({'error': 'Graph not found'}), 404
```

---

## Design System Integration

### CSS Tokens (Source of Truth)
All design values live in `frontend/src/styles/design-tokens.css`:

```css
:root {
  /* Colors */
  --md-primary: #00658d;
  --md-primary-container: #00adef;
  
  /* Typography */
  --font-display: 'Manrope', system-ui, sans-serif;
  --type-headline-lg: 600 2rem/1.2 var(--font-display);
  
  /* Spacing */
  --space-3: 1.5rem;
  
  /* Shadows */
  --shadow-card: 0 2px 16px rgba(25, 28, 32, 0.04);
}
```

**Component Rule:** Never hardcode colors, fonts, or spacing values. Always reference tokens:

```vue
<template>
  <!-- GOOD -->
  <div style="
    background: var(--md-surface-container-low);
    padding: var(--space-3);
    font: var(--type-body-md);
  ">
    Content
  </div>
  
  <!-- BAD -->
  <div style="
    background: #f1f4f9;
    padding: 16px;
    font-family: Inter;
  ">
    Content
  </div>
</template>
```

---

## Testing Standards

### Unit Tests (Jest/Pytest)

**Vue Components:**
- Test computed properties and methods
- Test prop validation
- Test event emissions
- Mock external dependencies (API calls)
- Minimum 80% coverage for critical paths

**Python Services:**
- Test happy path and error cases
- Use fixtures for setup/teardown
- Mock external dependencies (DB, LLM API)
- Test error handling with try/except blocks
- Minimum 80% coverage for critical paths

### Integration Tests

- End-to-end workflow testing (graph → simulation → report)
- Database state verification
- API response validation
- Performance benchmarking

### Example Test (Python)

```python
import pytest
from app.services import GraphBuilder

@pytest.fixture
def graph_config():
    return {'nodes': 100, 'edges': 500}

def test_build_valid_graph(graph_config):
    """Test building a valid graph."""
    builder = GraphBuilder(graph_config)
    graph = builder.build()
    
    assert graph is not None
    assert len(graph['nodes']) == 100
    assert len(graph['edges']) == 500

def test_build_invalid_config():
    """Test error handling for invalid config."""
    config = {'nodes': 0, 'edges': 100}
    builder = GraphBuilder(config)
    
    with pytest.raises(ValueError):
        builder.build()
```

---

## Documentation Requirements

### Code Comments
- **What:** Explain complex algorithms, business logic, workarounds
- **When:** For non-obvious behavior, edge cases, performance notes
- **Avoid:** Obvious comments that just restate the code

```python
# Good: Explains the why
# Use exponential backoff to avoid overwhelming the API during retries
def retry_with_backoff(func, max_retries=3):
    pass

# Bad: States the obvious
# Increment counter
counter += 1
```

### Docstrings (Python)

```python
def create_simulation(graph_id: str, config: Dict) -> str:
    """
    Create and execute a simulation on the given graph.
    
    Args:
        graph_id: ID of the graph to simulate.
        config: Simulation configuration dictionary.
        
    Returns:
        The simulation run ID.
        
    Raises:
        ValueError: If graph_id or config is invalid.
        TimeoutError: If simulation execution exceeds timeout.
    """
```

### JSDoc (JavaScript)

```javascript
/**
 * Fetch simulation results with optional filtering.
 * 
 * @param {string} simulationId - The simulation run ID.
 * @param {Object} filters - Optional filters (time_range, agent_id).
 * @returns {Promise<Object>} - Simulation results and metadata.
 * @throws {Error} - If simulation not found or fetch fails.
 */
export async function getSimulationResults(simulationId, filters = {}) {
```

---

## Git & Commit Standards

### Commit Message Format (Conventional Commits)

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat:` New feature
- `fix:` Bug fix
- `refactor:` Code restructure (no feature/fix)
- `perf:` Performance improvement
- `test:` Test updates
- `docs:` Documentation updates
- `chore:` Dependency updates, tooling (not in src)

**Examples:**
```
feat(simulation): add parallel execution support
fix(api): handle null graph references in report endpoint
refactor(components): extract common button styles to utility
docs(design): update token usage guidelines
```

### Branch Naming

```
feature/description-of-feature
bugfix/issue-number-description
refactor/component-name
docs/page-name
```

---

## Performance & Optimization

### Frontend
- Bundle size: Keep main chunk <500KB gzipped
- API calls: Debounce/throttle user input (300–500ms)
- Rendering: Memoize expensive computed properties
- Virtualization: For lists >100 items, use virtual scrolling

### Backend
- Database queries: Use indexes for frequently filtered columns
- Caching: Cache graph structures and simulation configs
- Pagination: Return max 100 results per API page
- Timeouts: Set reasonable timeouts for long operations (30s for simulations)

---

## Security Standards

### Frontend
- Input validation on all forms
- Sanitize user content before rendering
- Use HTTPS only in production
- No hardcoded API keys or credentials

### Backend
- Validate all user inputs (type, length, format)
- Use parameterized queries (no SQL injection)
- Hash passwords with bcrypt (if stored)
- Rate limit API endpoints
- Log sensitive operations (without exposing data)

### Shared
- Never commit `.env` files or credentials
- Rotate API keys regularly
- Use environment variables for all secrets

---

## Linting & Formatting

### Frontend (JavaScript/Vue)
- ESLint configuration: Standard rules + Vue plugin
- Prettier: Auto-format on save
- Pre-commit hook: Run linting before commit

### Backend (Python)
- Black: Code formatter
- Flake8 or Pylint: Linting
- isort: Import sorting
- Pre-commit hook: Run checks before commit

---

## CI/CD Requirements

### Pre-Commit
1. Linting passes
2. Tests pass (or skipped if WIP)
3. Code formatting auto-applied

### Pre-Push
1. All tests pass
2. No merge conflicts
3. All comments addressed

### Pre-Production
1. Build succeeds
2. Staging deployment verified
3. Smoke tests pass
4. Documentation updated
5. Changelog entry added

---

## Tools & Environment

| Tool | Purpose | Version |
|------|---------|---------|
| Node.js | Frontend build | 18+ |
| npm | Package manager | 9+ |
| Vue | Frontend framework | 3.5+ |
| Vite | Build tool | 7.2+ |
| Python | Backend runtime | 3.10+ |
| Flask | Web framework | 2.x |
| PostgreSQL | Database | 13+ |
| Docker | Containerization | 20+ |

---

## References

- **Design Tokens:** `frontend/src/styles/design-tokens.css`
- **Design Guidelines:** `docs/design-guidelines.md`
- **Architecture:** `docs/system-architecture.md`
- **Roadmap:** `docs/development-roadmap.md`

---

**Last Updated:** 2026-04-24
**Owner:** Engineering team
