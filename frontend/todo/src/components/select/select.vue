<template>
  <div class="popper">
    <select-button v-click-outside="vcoConfig" ref="reference" @click="toggleMenu"></select-button>
    <popper ref="popper" :visible="visible" :options="options" @select-option="onSelectOption"></popper>
  </div>
</template>

<script lang='ts'>
  import vClickOutside from 'v-click-outside'
  import Button from './button.vue';
  import Popper from './popper.vue'
  import { Component, Emit, Prop, Vue } from 'vue-property-decorator'

  Vue.use(vClickOutside)

  @Component({
    components: {
      'select-button': Button,
      'popper': Popper,
    }
  })
  export default class Select extends Vue {
    @Prop({ required: true }) options: { label: string, value: string | number | boolean }[]

    private visible:boolean = false

    private vcoConfig = {
      handler: this.onClickOutside,
      middleware: this.isNotClickedDropdown,
      isActive: true
    }
    
    onClickOutside (event) {
      this.visible = false
    }

    isNotClickedDropdown (event) {
      return event.target.className !== 'sl-dropdown'
    }

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
