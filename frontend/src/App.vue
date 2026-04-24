<template>
  <router-view />
</template>

<script setup>
// 使用 Vue Router 来管理页面
</script>

<style>
/* 全局样式重置 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

#app {
  font-family: var(--font-body);
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: var(--md-on-surface);
  background-color: var(--md-surface);
}

/* 滚动条样式 */
::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}

::-webkit-scrollbar-track {
  background: var(--md-surface-container-low);
}

::-webkit-scrollbar-thumb {
  background: var(--md-on-surface);
}

::-webkit-scrollbar-thumb:hover {
  background: var(--md-on-surface-variant);
}

/* 全局按钮样式 */
button {
  font-family: inherit;
}
</style>
