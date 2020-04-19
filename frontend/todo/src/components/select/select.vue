<template>
  <div class="popper">
    {{value}}
    <sl-input v-click-outside="vcoConfig" v-model="query" ref="reference" @click="toggleMenu"></sl-input>
    <popper ref="popper" :visible="visible" :options="filteredItems" @select-option="onSelectOption"></popper>
  </div>
</template>

<script lang='ts'>
  import vClickOutside from 'v-click-outside'
  import Input from './input.vue';
  import Popper from './popper.vue'
  import { Component, Emit, Prop, Vue } from 'vue-property-decorator'

  Vue.use(vClickOutside)

  @Component({
    components: {
      'sl-input': Input,
      'popper': Popper,
    }
  })
  export default class Select extends Vue {
    @Prop({ required: true }) value: string | number | boolean
    @Prop({ required: true }) options: { label: string, value: string | number | boolean }[]

    private visible:boolean = false
    private query:string = this.options.filter((option) => option.value === this.value)[0].label

    private vcoConfig = {
      handler: this.onClickOutside,
      middleware: this.isNotClickedDropdown,
      isActive: true
    }

    get regexp() { return new RegExp(`.*${this.query}.*`, 'g') }

    get filteredItems() {
      return this.options.filter((option) => option.label.match(this.regexp))
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
      if (val !== this.value) {
        this.onChange(val)
      }
    }

    @Emit('change')
    onChange(val) { }

  }
</script>
