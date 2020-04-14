<template>
  <ul v-show="visible">
    <slot></slot>
  </ul>
</template>

<script lang='ts'>
  import { Component, Prop, Vue } from 'vue-property-decorator';

  @Component
  export default class SelectMenu extends Vue {
    @Prop({ required: true }) private visible: boolean
  }
</script>
