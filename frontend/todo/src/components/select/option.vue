<template>
  <li @click.stop="onSelectOption" class="option-item">{{ label }}</li>
</template>

<script lang='ts'>
  import { Component, Prop, Emit, Vue } from 'vue-property-decorator'

  @Component
  export default class SelectOption extends Vue {
    @Prop({ required: true }) value: string | number | boolean
    @Prop({ required: true }) label: string

    @Emit('select-option')
    private onSelectOption(event): string | number | boolean {
      return this.value
    }
  }
</script>
