<style lang='scss' scoped>
  .sl-option-item {
    list-style: none;
    cursor: pointer;
    padding: 0 20px;
    font-size: 14px;
    color: #606266;
    height: 34px;
    line-height: 34px;
    &:hover {
      background: #F5F7FA;
    }
  }

  .is-selected {
    color: #409EFF;
    font-weight: bold;
  }

  .default-hover {
    background: #F5F7FA;
  }
</style>

<template>
  <li
    :class="{ 'is-selected': isSelected, 'default-hover': isDefaultHover }"
    class="sl-option-item"
    @click.stop="onSelectOption"
    @mouseenter="clearDefaultHover">
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
    @Prop({ required: true }) private isClearDefaultHover: boolean

    get isSelected(): boolean {
      return this.label === this.selectedLabel
    }

    get isDefaultHover(): boolean {
      return this.isSelected && !this.isClearDefaultHover
    }

    @Emit('select-option')
    private onSelectOption(): Val {
      return this.value
    }

    private clearDefaultHover(): void {
      this.$emit('clear-default-hover')
    }
  }
</script>
