<style lang='scss'>
  .sl-scrollbar {
    position: absolute;
    right: 2px;
    bottom: 2px;
    z-index: 1;
    opacity: 0;
    transition: opacity 120ms ease-out;
    &.is-vertical {
      width: 6px;
      top: 2px;
      transform: translateY(0%);
    }
    &.is-horizontal {
      height: 6px;
      left: 2px;
      transform: translateX(0%);
    }
  }
  
  .sl-option-wrapper:hover {
    .sl-scrollbar {
      opacity: 1;
      transition: opacity 340ms ease-out;
    }
  }

  .bar {
    cursor: pointer;
    background-color: rgba(144, 147, 153, 0.3);
    border-radius: 4px;
  }
</style>

<template>
  <div class="sl-scrollbar is-vertical"><div :style="{ height: height }" class="bar"></div></div>
</template>

<script lang='ts'>
  import { Component, Prop, Vue } from 'vue-property-decorator'

  @Component
  export default class extends Vue {
    @Prop({ required: true }) private heightPercentage: number

    get height() {
      // メニューの高さが最大の高さに収まっている場合は、スクロールバーを表示しない
      return this.heightPercentage < 100 ? `${this.heightPercentage}%` : ''
    }

  }
</script>
