<style lang='scss' scoped>
  .sl-input {
    box-sizing: border-box;
    padding-right: 30px;
    width: 100%;
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

  .is-disabled {
    cursor: not-allowed;
  }
</style>

<template>
  <div class="sl-input-wrapper" :class="{ 'with-icons': hasIcons }">
    <input
      v-model="query"
      :placeholder="placeholder"
      :disabled="disabled"
      :readonly="readonly"
      :class="{ 'is-disabled': disabled }"
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
