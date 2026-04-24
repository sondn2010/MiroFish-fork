<template>
  <div class="home-container">
    <!-- 顶部导航栏 -->
    <nav class="navbar">
      <div class="nav-brand">SARDINES</div>
      <div class="nav-links">
        <LanguageSwitcher />
        <a href="https://github.com/666ghj/Sardines" target="_blank" class="github-link">
          {{ $t('nav.visitGithub') }} <span class="arrow">↗</span>
        </a>
      </div>
    </nav>

    <div class="main-content">
      <!-- 上半部分：Hero 区域 -->
      <section class="hero-section">
        <div class="hero-left">
          <div class="tag-row">
            <span class="orange-tag">{{ $t('home.tagline') }}</span>
            <span class="version-text">{{ $t('home.version') }}</span>
          </div>
          
          <h1 class="main-title">
            {{ $t('home.heroTitle1') }}<br>
            <span class="gradient-text">{{ $t('home.heroTitle2') }}</span>
          </h1>
          
          <div class="hero-desc">
            <p>
              <i18n-t keypath="home.heroDesc" tag="span">
                <template #brand><span class="highlight-bold">{{ $t('home.heroDescBrand') }}</span></template>
                <template #agentScale><span class="highlight-orange">{{ $t('home.heroDescAgentScale') }}</span></template>
                <template #optimalSolution><span class="highlight-code">{{ $t('home.heroDescOptimalSolution') }}</span></template>
              </i18n-t>
            </p>
            <p class="slogan-text">
              {{ $t('home.slogan') }}<span class="blinking-cursor">_</span>
            </p>
          </div>
           
          <div class="decoration-square"></div>
        </div>
        
        <div class="hero-right">
          <!-- Logo 区域 -->
          <div class="logo-container">
            <img src="../assets/logo/sardines-logo.png" alt="Sardines Logo" class="hero-logo" />
          </div>
          
          <button class="scroll-down-btn" @click="scrollToBottom">
            ↓
          </button>
        </div>
      </section>

      <!-- 下半部分：双栏布局 -->
      <section class="dashboard-section">
        <!-- 左栏：状态与步骤 -->
        <div class="left-panel">
          <div class="panel-header">
            <span class="status-dot">■</span> {{ $t('home.systemStatus') }}
          </div>
          
          <h2 class="section-title">{{ $t('home.systemReady') }}</h2>
          <p class="section-desc">
            {{ $t('home.systemReadyDesc') }}
          </p>
          
          <!-- 数据指标卡片 -->
          <div class="metrics-row">
            <div class="metric-card">
              <div class="metric-value">{{ $t('home.metricLowCost') }}</div>
              <div class="metric-label">{{ $t('home.metricLowCostDesc') }}</div>
            </div>
            <div class="metric-card">
              <div class="metric-value">{{ $t('home.metricHighAvail') }}</div>
              <div class="metric-label">{{ $t('home.metricHighAvailDesc') }}</div>
            </div>
          </div>

          <!-- 项目模拟步骤介绍 (新增区域) -->
          <div class="steps-container">
            <div class="steps-header">
               <span class="diamond-icon">◇</span> {{ $t('home.workflowSequence') }}
            </div>
            <div class="workflow-list">
              <div class="workflow-item">
                <span class="step-num">01</span>
                <div class="step-info">
                  <div class="step-title">{{ $t('home.step01Title') }}</div>
                  <div class="step-desc">{{ $t('home.step01Desc') }}</div>
                </div>
              </div>
              <div class="workflow-item">
                <span class="step-num">02</span>
                <div class="step-info">
                  <div class="step-title">{{ $t('home.step02Title') }}</div>
                  <div class="step-desc">{{ $t('home.step02Desc') }}</div>
                </div>
              </div>
              <div class="workflow-item">
                <span class="step-num">03</span>
                <div class="step-info">
                  <div class="step-title">{{ $t('home.step03Title') }}</div>
                  <div class="step-desc">{{ $t('home.step03Desc') }}</div>
                </div>
              </div>
              <div class="workflow-item">
                <span class="step-num">04</span>
                <div class="step-info">
                  <div class="step-title">{{ $t('home.step04Title') }}</div>
                  <div class="step-desc">{{ $t('home.step04Desc') }}</div>
                </div>
              </div>
              <div class="workflow-item">
                <span class="step-num">05</span>
                <div class="step-info">
                  <div class="step-title">{{ $t('home.step05Title') }}</div>
                  <div class="step-desc">{{ $t('home.step05Desc') }}</div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- 右栏：交互控制台 -->
        <div class="right-panel">
          <div class="console-box">
            <!-- 上传区域 -->
            <div class="console-section">
              <div class="console-header">
                <span class="console-label">{{ $t('home.realitySeed') }}</span>
                <span class="console-meta">{{ $t('home.supportedFormats') }}</span>
              </div>
              
              <div 
                class="upload-zone"
                :class="{ 'drag-over': isDragOver, 'has-files': files.length > 0 }"
                @dragover.prevent="handleDragOver"
                @dragleave.prevent="handleDragLeave"
                @drop.prevent="handleDrop"
                @click="triggerFileInput"
              >
                <input
                  ref="fileInput"
                  type="file"
                  multiple
                  accept=".pdf,.md,.txt"
                  @change="handleFileSelect"
                  style="display: none"
                  :disabled="loading"
                />
                
                <div v-if="files.length === 0" class="upload-placeholder">
                  <div class="upload-icon">↑</div>
                  <div class="upload-title">{{ $t('home.dragToUpload') }}</div>
                  <div class="upload-hint">{{ $t('home.orBrowse') }}</div>
                </div>
                
                <div v-else class="file-list">
                  <div v-for="(file, index) in files" :key="index" class="file-item">
                    <span class="file-icon">📄</span>
                    <span class="file-name">{{ file.name }}</span>
                    <button @click.stop="removeFile(index)" class="remove-btn">×</button>
                  </div>
                </div>
              </div>
            </div>

            <!-- 分割线 -->
            <div class="console-divider">
              <span>{{ $t('home.inputParams') }}</span>
            </div>

            <!-- 输入区域 -->
            <div class="console-section">
              <div class="console-header">
                <span class="console-label">{{ $t('home.simulationPrompt') }}</span>
              </div>
              <div class="input-wrapper">
                <textarea
                  v-model="formData.simulationRequirement"
                  class="code-input"
                  :placeholder="$t('home.promptPlaceholder')"
                  rows="6"
                  :disabled="loading"
                ></textarea>
                <div class="model-badge">{{ $t('home.engineBadge') }}</div>
              </div>
            </div>

            <!-- 启动按钮 -->
            <div class="console-section btn-section">
              <button 
                class="start-engine-btn"
                @click="startSimulation"
                :disabled="!canSubmit || loading"
              >
                <span v-if="!loading">{{ $t('home.startEngine') }}</span>
                <span v-else>{{ $t('home.initializing') }}</span>
                <span class="btn-arrow">→</span>
              </button>
            </div>
          </div>
        </div>
      </section>

      <!-- 历史项目数据库 -->
      <HistoryDatabase />
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import HistoryDatabase from '../components/HistoryDatabase.vue'
import LanguageSwitcher from '../components/LanguageSwitcher.vue'

const router = useRouter()

// 表单数据
const formData = ref({
  simulationRequirement: ''
})

// 文件列表
const files = ref([])

// 状态
const loading = ref(false)
const error = ref('')
const isDragOver = ref(false)

// 文件输入引用
const fileInput = ref(null)

// 计算属性:是否可以提交
const canSubmit = computed(() => {
  return formData.value.simulationRequirement.trim() !== '' && files.value.length > 0
})

// 触发文件选择
const triggerFileInput = () => {
  if (!loading.value) {
    fileInput.value?.click()
  }
}

// 处理文件选择
const handleFileSelect = (event) => {
  const selectedFiles = Array.from(event.target.files)
  addFiles(selectedFiles)
}

// 处理拖拽相关
const handleDragOver = (e) => {
  if (!loading.value) {
    isDragOver.value = true
  }
}

const handleDragLeave = (e) => {
  isDragOver.value = false
}

const handleDrop = (e) => {
  isDragOver.value = false
  if (loading.value) return
  
  const droppedFiles = Array.from(e.dataTransfer.files)
  addFiles(droppedFiles)
}

// 添加文件
const addFiles = (newFiles) => {
  const validFiles = newFiles.filter(file => {
    const ext = file.name.split('.').pop().toLowerCase()
    return ['pdf', 'md', 'txt'].includes(ext)
  })
  files.value.push(...validFiles)
}

// 移除文件
const removeFile = (index) => {
  files.value.splice(index, 1)
}

// 滚动到底部
const scrollToBottom = () => {
  window.scrollTo({
    top: document.body.scrollHeight,
    behavior: 'smooth'
  })
}

// 开始模拟 - 立即跳转，API调用在Process页面进行
const startSimulation = () => {
  if (!canSubmit.value || loading.value) return
  
  // 存储待上传的数据
  import('../store/pendingUpload.js').then(({ setPendingUpload }) => {
    setPendingUpload(files.value, formData.value.simulationRequirement)
    
    // 立即跳转到Process页面（使用特殊标识表示新建项目）
    router.push({
      name: 'Process',
      params: { projectId: 'new' }
    })
  })
}
</script>

<style scoped>
.home-container {
  min-height: 100vh;
  background: var(--md-surface);
  font-family: var(--font-body);
  color: var(--md-on-surface);
}

/* 顶部导航 — glassmorphism */
.navbar {
  height: 60px;
  background: var(--glass-bg);
  backdrop-filter: var(--glass-blur);
  -webkit-backdrop-filter: var(--glass-blur);
  color: var(--md-on-surface);
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 40px;
  box-shadow: 0 2px 24px rgba(25, 28, 32, 0.04);
  position: sticky;
  top: 0;
  z-index: 100;
}

.nav-brand {
  font-family: var(--font-display);
  font-weight: 800;
  letter-spacing: var(--tracking-display);
  font-size: 1.2rem;
  text-transform: uppercase;
  color: var(--md-primary);
}

.nav-links {
  display: flex;
  align-items: center;
  gap: 16px;
}

.github-link {
  color: var(--md-on-surface-variant);
  text-decoration: none;
  font-family: var(--font-body);
  font-size: 0.9rem;
  font-weight: 500;
  display: flex;
  align-items: center;
  gap: 8px;
  transition: opacity 0.2s;
}

.github-link:hover {
  opacity: 0.8;
}

.arrow {
  font-family: sans-serif;
}

/* 主要内容区 */
.main-content {
  max-width: 1400px;
  margin: 0 auto;
  padding: 60px 40px;
}

/* Hero 区域 */
.hero-section {
  display: flex;
  justify-content: space-between;
  margin-bottom: 80px;
  position: relative;
}

.hero-section::after {
  content: '';
  position: absolute;
  top: -10%;
  right: -10%;
  width: 60%;
  aspect-ratio: 1;
  background-image: url('@/assets/logo/sardines-logo.png');
  background-size: contain;
  background-repeat: no-repeat;
  opacity: 0.05;
  pointer-events: none;
  z-index: 0;
}

.hero-left {
  flex: 1;
  padding-right: 60px;
  position: relative;
  z-index: 1;
}

.tag-row {
  display: flex;
  align-items: center;
  gap: 15px;
  margin-bottom: 25px;
  font-family: var(--font-body);
  font-size: 0.8rem;
}

.orange-tag {
  background: var(--gradient-cta);
  color: var(--md-on-primary);
  padding: 4px 10px;
  font-weight: 700;
  letter-spacing: var(--tracking-label);
  font-size: 0.75rem;
  text-transform: uppercase;
  border-radius: var(--round-four);
}

.version-text {
  color: var(--md-outline);
  font-weight: 500;
  letter-spacing: 0.5px;
}

.main-title {
  font: var(--type-display-lg);
  letter-spacing: var(--tracking-display);
  margin: 0 0 40px 0;
  color: var(--md-on-surface);
}

.gradient-text {
  background: var(--gradient-cta);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  display: inline-block;
}

.hero-desc {
  font-size: 1.05rem;
  line-height: 1.8;
  color: var(--md-on-surface-variant);
  max-width: 640px;
  margin-bottom: 50px;
  font-weight: 400;
  text-align: justify;
}

.hero-desc p {
  margin-bottom: 1.5rem;
}

.highlight-bold {
  color: var(--md-on-surface);
  font-weight: 700;
}

.highlight-orange {
  color: var(--md-primary);
  font-weight: 700;
  font-family: var(--font-display);
}

.highlight-code {
  background: var(--md-surface-container);
  padding: 2px 6px;
  border-radius: var(--round-four);
  font-family: var(--font-body);
  font-size: 0.9em;
  color: var(--md-on-surface);
  font-weight: 600;
}

.slogan-text {
  font-size: 1.2rem;
  font-weight: 500;
  color: var(--md-on-surface);
  letter-spacing: 1px;
  border-left: 3px solid var(--md-primary);
  padding-left: 15px;
  margin-top: 20px;
}

.blinking-cursor {
  color: var(--md-primary);
  animation: blink 1s step-end infinite;
  font-weight: 700;
}

@keyframes blink {
  0%, 100% { opacity: 1; }
  50% { opacity: 0; }
}

.decoration-square {
  width: 16px;
  height: 16px;
  background: var(--gradient-cta);
  border-radius: var(--round-four);
}

.hero-right {
  flex: 0.8;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: flex-end;
  position: relative;
  z-index: 1;
}

.logo-container {
  width: 100%;
  display: flex;
  justify-content: flex-end;
  padding-right: 40px;
}

.hero-logo {
  max-width: 500px;
  width: 100%;
}

.scroll-down-btn {
  width: 40px;
  height: 40px;
  border: 1px solid var(--md-outline-variant);
  background: transparent;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  color: var(--md-primary);
  font-size: 1.2rem;
  transition: all 0.2s;
  border-radius: var(--round-four);
}

.scroll-down-btn:hover {
  border-color: var(--md-primary);
}

/* Dashboard 双栏布局 */
.dashboard-section {
  display: flex;
  gap: 60px;
  padding-top: 60px;
  align-items: flex-start;
  background: var(--md-surface-container-low);
  border-radius: var(--round-lg);
  padding: 60px 40px;
}

.dashboard-section .left-panel,
.dashboard-section .right-panel {
  display: flex;
  flex-direction: column;
}

/* 左侧面板 */
.left-panel {
  flex: 0.8;
}

.panel-header {
  font-family: var(--font-body);
  font-size: 0.8rem;
  color: var(--md-outline);
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 20px;
  text-transform: uppercase;
  letter-spacing: var(--tracking-label);
}

.status-dot {
  color: var(--md-primary);
  font-size: 0.8rem;
}

.section-title {
  font: var(--type-headline-lg);
  letter-spacing: var(--tracking-display);
  margin: 0 0 15px 0;
}

.section-desc {
  color: var(--md-on-surface-variant);
  margin-bottom: 25px;
  line-height: 1.6;
}

.metrics-row {
  display: flex;
  gap: 20px;
  margin-bottom: 15px;
}

.metric-card {
  background: var(--md-surface-container-lowest);
  box-shadow: var(--shadow-card);
  padding: 20px 30px;
  min-width: 150px;
  border-radius: var(--round-four);
}

.metric-value {
  font-family: var(--font-display);
  font-size: 1.8rem;
  font-weight: 700;
  margin-bottom: 5px;
  color: var(--md-primary);
}

.metric-label {
  font-size: 0.85rem;
  color: var(--md-outline);
}

/* 项目模拟步骤介绍 */
.steps-container {
  background: var(--md-surface-container-lowest);
  box-shadow: var(--shadow-card);
  padding: 30px;
  position: relative;
  border-radius: var(--round-four);
}

.steps-header {
  font-family: var(--font-body);
  font-size: 0.8rem;
  color: var(--md-outline);
  margin-bottom: 25px;
  display: flex;
  align-items: center;
  gap: 8px;
  text-transform: uppercase;
  letter-spacing: var(--tracking-label);
}

.diamond-icon {
  font-size: 1.2rem;
  line-height: 1;
  color: var(--md-primary);
}

.workflow-list {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.workflow-item {
  display: flex;
  align-items: flex-start;
  gap: 20px;
}

.step-num {
  font-family: var(--font-display);
  font-weight: 700;
  color: var(--md-on-surface);
  opacity: 0.3;
}

.step-info {
  flex: 1;
}

.step-title {
  font-weight: 600;
  font-size: 1rem;
  margin-bottom: 4px;
}

.step-desc {
  font-size: 0.85rem;
  color: var(--md-on-surface-variant);
}

/* 右侧交互控制台 */
.right-panel {
  flex: 1.2;
}

.console-box {
  background: var(--md-surface-container-lowest);
  box-shadow: var(--shadow-float);
  padding: 8px;
  border-radius: var(--round-four);
}

.console-section {
  padding: 20px;
}

.console-section.btn-section {
  padding-top: 0;
}

.console-header {
  display: flex;
  justify-content: space-between;
  margin-bottom: 15px;
  font-family: var(--font-body);
  font-size: 0.75rem;
  color: var(--md-on-surface-variant);
  text-transform: uppercase;
  letter-spacing: var(--tracking-label);
}

.upload-zone {
  border: 1px dashed var(--md-outline-variant);
  height: 200px;
  overflow-y: auto;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s;
  background: var(--md-surface-container-highest);
  border-radius: var(--round-four);
}

.upload-zone.has-files {
  align-items: flex-start;
}

.upload-zone:hover {
  background: var(--md-surface-container-high);
  border-color: var(--md-primary);
}

.upload-placeholder {
  text-align: center;
}

.upload-icon {
  width: 40px;
  height: 40px;
  border: 1px solid var(--md-outline-variant);
  border-radius: var(--round-four);
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 15px;
  color: var(--md-outline);
}

.upload-title {
  font-weight: 500;
  font-size: 0.9rem;
  margin-bottom: 5px;
  color: var(--md-on-surface);
}

.upload-hint {
  font-family: var(--font-body);
  font-size: 0.75rem;
  color: var(--md-outline);
}

.file-list {
  width: 100%;
  padding: 15px;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.file-item {
  display: flex;
  align-items: center;
  background: var(--md-surface-container-lowest);
  padding: 8px 12px;
  border: 1px solid var(--md-outline-variant);
  border-radius: var(--round-four);
  font-family: var(--font-body);
  font-size: 0.85rem;
}

.file-name {
  flex: 1;
  margin: 0 10px;
  color: var(--md-on-surface);
}

.remove-btn {
  background: none;
  border: none;
  cursor: pointer;
  font-size: 1.2rem;
  color: var(--md-outline);
}

.console-divider {
  display: flex;
  align-items: center;
  margin: 10px 0;
}

.console-divider::before,
.console-divider::after {
  content: '';
  flex: 1;
  height: 1px;
  background: var(--md-surface-container);
}

.console-divider span {
  padding: 0 15px;
  font-family: var(--font-body);
  font-size: 0.7rem;
  color: var(--md-outline);
  letter-spacing: var(--tracking-label);
  text-transform: uppercase;
}

.input-wrapper {
  position: relative;
  background: var(--md-surface-container-highest);
  border-bottom: 2px solid transparent;
  border-radius: var(--round-four) var(--round-four) 0 0;
}

.input-wrapper:focus-within {
  border-bottom-color: var(--md-primary);
}

.code-input {
  width: 100%;
  border: none;
  background: transparent;
  padding: 20px;
  font-family: var(--font-body);
  font-size: 0.9rem;
  line-height: 1.6;
  resize: vertical;
  outline: none;
  min-height: 150px;
  color: var(--md-on-surface);
}

.model-badge {
  position: absolute;
  bottom: 10px;
  right: 15px;
  font-family: var(--font-body);
  font-size: 0.7rem;
  color: var(--md-outline);
  text-transform: uppercase;
  letter-spacing: var(--tracking-label);
}

.start-engine-btn {
  width: 100%;
  background: var(--gradient-cta);
  color: var(--md-on-primary);
  border: none;
  padding: 20px;
  font-family: var(--font-display);
  font-weight: 700;
  font-size: 1.1rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
  cursor: pointer;
  transition: all 0.3s ease;
  letter-spacing: var(--tracking-label);
  text-transform: uppercase;
  position: relative;
  overflow: hidden;
  border-radius: var(--round-four);
}

.start-engine-btn:not(:disabled) {
  animation: pulse-border 2s infinite;
}

.start-engine-btn:hover:not(:disabled) {
  opacity: 0.9;
  transform: translateY(-2px);
  box-shadow: var(--shadow-float);
}

.start-engine-btn:active:not(:disabled) {
  transform: translateY(0);
}

.start-engine-btn:disabled {
  background: var(--md-surface-container);
  color: var(--md-outline);
  cursor: not-allowed;
  transform: none;
}

@keyframes pulse-border {
  0% { box-shadow: 0 0 0 0 rgba(0, 101, 141, 0.3); }
  70% { box-shadow: 0 0 0 8px rgba(0, 101, 141, 0); }
  100% { box-shadow: 0 0 0 0 rgba(0, 101, 141, 0); }
}

/* 响应式适配 */
@media (max-width: 1024px) {
  .dashboard-section {
    flex-direction: column;
  }

  .hero-section {
    flex-direction: column;
  }

  .hero-left {
    padding-right: 0;
    margin-bottom: 40px;
  }

  .hero-logo {
    max-width: 200px;
    margin-bottom: 20px;
  }
}
</style>

<style>
/* English locale adjustments (unscoped) */
html[lang="en"] .main-title {
  font-size: 3.5rem;
  letter-spacing: -0.02em;
}

html[lang="en"] .hero-desc {
  text-align: left;
}
</style>
