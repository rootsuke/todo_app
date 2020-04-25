<template>
  <div class="popper">
    {{value}}
    <sl-input v-click-outside="vcoConfig" v-model="query" ref="reference" :disabled="disabled" :placeholder="placeholder" @click="toggleMenu"></sl-input>
    <popper ref="popper" :visible="visible" :options="filteredItems" @select-option="onSelectOption"></popper>
  </div>
</template>

<script lang='ts'>
  import vClickOutside from 'v-click-outside'
  import Input from './input.vue';
  import Popper from './popper.vue'
  import { Component, Emit, Prop, Vue, Watch } from 'vue-property-decorator'

  type Val = string | number | boolean;
  type Event = { target: { className: string } };

  Vue.use(vClickOutside)

  @Component({
    components: {
      'sl-input': Input,
      'popper': Popper,
    }
  })
  export default class Select extends Vue {
    @Prop({ required: true }) value: Val
    @Prop({ required: true }) options: { label: string, value: Val }[]
    @Prop({ required: false, default: false }) disabled: boolean

    private visible:boolean = false
    private query:string = ''
    private selectedLabel:string = ''
    private placeholder:string = ''

    private vcoConfig = {
      handler: this.onClickOutside,
      middleware: this.isNotClickedDropdown,
      isActive: true
    }

    get regexp() { return new RegExp(`.*${this.query}.*`, 'g') }

    get filteredItems() {
      return this.options.filter((option) => option.label.match(this.regexp))
    }

    @Watch('value')
    onChangeValue(val: Val) {
      this.selectedLabel = this.getSelectedLabel(this.value)
      this.query = this.selectedLabel
    }

    @Watch('visible')
    onChangeVisible(isOpen: boolean) {
      if (isOpen) {
        this.query = ''
        this.placeholder = this.selectedLabel
      } else {
        this.query = this.selectedLabel
        this.placeholder = ''
      }
    }

    mounted() {
      this.selectedLabel = this.getSelectedLabel(this.value)
      this.query = this.selectedLabel
    }
    
    onClickOutside() {
      this.visible = false
    }

    isNotClickedDropdown(event: Event) {
      return event.target.className !== 'sl-dropdown'
    }

    toggleMenu() {
      if (this.disabled) { return }
      this.visible = !this.visible
    }

    getSelectedLabel(val: Val): string {
      const selectedOption = this.options.find((option) => option.value === val)
      return selectedOption ? selectedOption.label : ''
    }

    @Emit('input')
    onSelectOption(val: Val) {
      console.log(val)
      this.visible = false
      if (val !== this.value) {
        this.onChange(val)
      }
    }

    @Emit('change')
    onChange(val: Val) { }

  }
</script>
