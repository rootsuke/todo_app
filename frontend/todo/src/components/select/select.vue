<template>
  <div class="popper">
    <select-button ref="reference" @click="toggleMenu"></select-button>
    <popper ref="popper" :visible="visible" :options="options" @select-option="onSelectOption"></popper>
  </div>
</template>

<script lang='ts'>
  import Button from './button.vue';
  import Popper from './popper.vue'
  import { Component, Emit, Prop, Vue } from 'vue-property-decorator'

  @Component({
    components: {
      'select-button': Button,
      'popper': Popper,
    }
  })
  export default class Select extends Vue {
    @Prop({ required: true }) options: { label: string, value: string | number | boolean }[]

    private visible:boolean = false

    toggleMenu() {
      this.visible = !this.visible
    }

    @Emit('input')
    onSelectOption(val) {
      console.log(val)
      this.visible = false
      return val
    }

  }
</script>
