<style lang='scss' scoped>
  .sl-option-item {
    list-style: none;
    cursor: pointer;
    padding: 0 20px;
    font-size: 14px;
    color: #606266;
    height: 34px;
    line-height: 34px;
  }

  .is-selected {
    color: #409EFF;
    font-weight: bold;
  }

  .is-hover {
    background: #F5F7FA;
  }
</style>

<template>
  <li
    :class="{ 'is-selected': isSelected, 'is-hover': isHover }"
    class="sl-option-item"
    @click.stop="onSelectOption"
    @mouseenter.stop="onHoverOption">
    {{ label }}
  </li>
</template>

<script lang='ts'>
  import { Component, Prop, Emit, Vue, Watch } from 'vue-property-decorator'
  type Val = string | number | boolean;

  @Component
  export default class SelectOption extends Vue {
    @Prop({ required: true }) private value: Val
    @Prop({ required: true }) private label: string
    @Prop({ required: true }) private selectedLabel: string
    @Prop({ required: true }) private hoverLabel: string

    get isSelected(): boolean {
      return this.label === this.selectedLabel
    }

    get isHover(): boolean {
      return this.label === this.hoverLabel
    }

    private onSelectOption(): void {
      this.$emit('select-option', this.value)
    }

    private onHoverOption(): void {
      this.$emit('hover-option', this.label)
    }
  }
</script>
