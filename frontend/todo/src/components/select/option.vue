<template>
  <li @click.stop="onSelectOption" class="option-item">{{ label }}</li>
</template>

<script lang='ts'>
  import { Component, Prop, Emit, Vue } from 'vue-property-decorator'
  type Val = string | number | boolean;

  @Component
  export default class SelectOption extends Vue {
    @Prop({ required: true }) private value: Val
    @Prop({ required: true }) private label: string

    @Emit('select-option')
    private onSelectOption(): Val {
      return this.value
    }
  }
</script>
