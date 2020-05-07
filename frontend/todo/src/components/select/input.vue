<style lang='scss' scoped>
  .sl-input {
    box-sizing: border-box;
    padding: 0 30px 0 15px;
    width: 100%;
    height: 40px;
    line-height: 40px;
    color: #606266;
    border-radius: 4px;
    border: 1px solid #DCDFE6;
    font-size: 14px;
    transition: border-color .3s cubic-bezier(.645,.045,.355,1);
    transition-property: border-color;
    transition-duration: 0.5s;
    transition-timing-function: cubic-bezier(0.645, 0.045, 0.355, 1);
    transition-delay: 0s;
    &:hover {
      border-color: #C0C4CC;
    }
    &:focus {
      border-color: #409EFF;
      outline: 0;
    }
    &::placeholder {
      color: #C0C4CC;
    }
  }

  .with-icons {
    position: relative;
  }

  .input-icons {
    position: absolute;
    top: 0;
    right: 5px;
    height: 100%;
    text-align: center;
  }

  .is-disabled .sl-input {
    background-color: #F5F7FA;
    border-color: #E4E7ED;
    color: #C0C4CC;
  }
</style>

<template>
  <div
    :class="{ 'with-icons': hasIcons, 'is-disabled': disabled }"
    class="sl-input-wrapper">
    <input
      v-model="query"
      :placeholder="placeholder"
      :disabled="disabled"
      :readonly="readonly"
      class="sl-input"
      aria-describedby="tooltip"
      @blur="onBlur" />
    <span v-if="hasIcons" class="input-icons">
      <template>
        <slot name="icons"></slot>
      </template>
    </span>
  </div>
</template>

<script lang='ts'>
  import { Component, Vue, Emit, Prop } from 'vue-property-decorator'

  @Component
  export default class Input extends Vue {
    @Prop({ required: true }) private value: string
    @Prop({ required: true }) private placeholder: string
    @Prop({ required: false, default: false }) private disabled: boolean
    @Prop({ required: false, default: false }) private readonly: boolean

    get query() { return this.value }
    set query(val: string) { this.input(val) }

    get hasIcons() {
      return this.$slots.icons
    }

    @Emit('input')
    private input(val: string) { return val }

    @Emit('blur')
    private onBlur() {}

  }
</script>
