<template>
  <button id="button" aria-describedby="tooltip" @click="onClick" @blur="onBlur">My button</button>
</template>

<script lang='ts'>
  import { Component, Vue, Emit } from 'vue-property-decorator'

  @Component
  export default class Button extends Vue {

    @Emit('click')
    private onClick() {}

    @Emit('blur')
    private onBlur() {}

  }
</script>
