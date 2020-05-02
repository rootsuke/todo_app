<style lang='scss' scoped>
  .sl-select-input {
    cursor: pointer;
  }
</style>

<template>
  <div v-click-outside="vcoConfig" class="sl-select" @click="toggleMenu">
    <sl-input v-model="tmpQuery" ref="reference" :disabled="disabled" :readonly="readonly" :placeholder="placeholder" class="sl-select-input"></sl-input>
    <popper ref="popper" :visible="visible" :options="filteredItems" @select-option="onSelectOption"></popper>
  </div>
</template>

<script lang='ts'>
  import vClickOutside from 'v-click-outside'
  import Input from './input.vue';
  import Popper from './popper.vue'
  import { Component, Emit, Prop, Vue, Watch } from 'vue-property-decorator'

  type Val = string | number | boolean;
  interface Event { target: { className: string } };

  Vue.use(vClickOutside)

  @Component({
    components: {
      'sl-input': Input,
      'popper': Popper,
    },
  })
  export default class Select extends Vue {
    @Prop({ required: true }) private value: Val
    @Prop({ required: true }) private options: Array<{ label: string, value: Val }>
    @Prop({ required: false, default: false }) private disabled: boolean
    @Prop({ required: false, default: false }) private filterable: boolean

    private visible: boolean = false
    private tmpQuery: string = ''
    private query: string = ''
    private selectedLabel: string = ''
    private placeholder: string = ''
    private mousedownClass: string = ''

    private vcoConfig = {
      handler: this.onClickOutside,
      middleware: this.isNotClickedDropdown,
      events: ['mousedown', 'mouseup'],
      isActive: true,
    }

    get readonly() { return !this.filterable || !this.visible }

    get regexp() { return new RegExp(`.*${this.query}.*`, 'g') }

    get filteredItems() {
      return this.options.filter((option) => option.label.match(this.regexp))
    }

    @Watch('value')
    private onChangeValue(val: Val): void {
      this.selectedLabel = this.getSelectedLabel(this.value)
      this.tmpQuery = this.selectedLabel
    }

    @Watch('visible')
    private onChangeVisible(isOpen: boolean): void {
      if (isOpen) {
        if (this.filterable) {
          this.tmpQuery = ''
          this.placeholder = this.selectedLabel
        }
      } else {
        if (this.selectedLabel && this.filterable) {
          this.tmpQuery = this.selectedLabel
          this.placeholder = ''
        }
      }
    }

    @Watch('tmpQuery')
    private onChangeTmpQuery(val: string): void {
      if (this.filterable) {
        this.query = this.tmpQuery
      }
    }

    private mounted(): void {
      this.selectedLabel = this.getSelectedLabel(this.value)
      this.tmpQuery = this.selectedLabel
    }

    private onClickOutside(): void {
      this.visible = false
    }

    private isNotClickedDropdown(event: MouseEvent): boolean {
      const className = (<HTMLElement>event.target).className
      if (event.type === 'mousedown') {
        this.mousedownClass = className
        return false
      } else {
        return this.mousedownClass !== 'sl-option-item' && className !== 'sl-option-item'
      }
    }

    private toggleMenu(): void {
      if (this.disabled) { return }
      this.visible = !this.visible
    }

    private getSelectedLabel(val: Val): string {
      const selectedOption = this.options.find((option) => option.value === val)
      return selectedOption ? selectedOption.label : ''
    }

    @Emit('input')
    private onSelectOption(val: Val): void {
      console.log(val)
      this.visible = false
      if (val !== this.value) {
        this.onChange(val)
      }
    }

    @Emit('change')
    private onChange(val: Val) { return val }

  }
</script>
