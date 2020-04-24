<template>
  <input v-model="query" :placeholder="placeholder" class="sl-input" aria-describedby="tooltip" @click="onClick" @blur="onBlur" />
</template>

<script lang='ts'>
  import { Component, Vue, Emit, Prop } from 'vue-property-decorator'

  @Component
  export default class Button extends Vue {
    @Prop({ required: true }) value: string
    @Prop({ required: true }) placeholder: string

    get query() { return this.value }
    set query(val: string) { this.input(val) }

    @Emit('input')
    private input(val: string) {}

    @Emit('click')
    private onClick() {}

    @Emit('blur')
    private onBlur() {}

  }
</script>
