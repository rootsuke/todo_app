<style lang='scss' scoped>
  .is-disabled {
    cursor: not-allowed;
  }
</style>

<template>
  <input 
    v-model="query"
    :placeholder="placeholder"
    :disabled="disabled"
    :readonly="readonly"
    :class="{ 'is-disabled': disabled }"
    class="sl-input"
    aria-describedby="tooltip"
    @blur="onBlur" />
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

    @Emit('input')
    private input(val: string) { return val }

    @Emit('blur')
    private onBlur() {}

  }
</script>
