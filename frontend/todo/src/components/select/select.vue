<style lang='scss'>
  .sl-select {
    display: inline-block;
  }

  .sl-select .sl-input {
    cursor: pointer;
  }
  
  .sl-select .is-disabled .sl-input {
    cursor: not-allowed;
  }

  .sl-icon {
    cursor: pointer;
    width: 25px;
    height: 100%;
    line-height: 40px;
    color: #C0C4CC;
    text-align: center;
    transition: all .3s;
    transition-property: all;
    transition-duration: 0.3s;
    transition-timing-function: ease;
    transition-delay: 0s;
  }

  .is-reverse {
    transform: rotate(-180deg);
  }
</style>

<template>
  <div v-click-outside="vcoConfig" class="sl-select" @click.stop="toggleMenu">
    <sl-input
      v-model="tmpQuery"
      ref="reference"
      :disabled="disabled"
      :readonly="readonly"
      :placeholder="currentPlaceholder"
      @mouseenter.native="isInputHover = true"
      @mouseleave.native="isInputHover = false">
      <template slot="icons">
        <i v-show="!showClearBtn" :class="{ 'is-reverse': isReverse }" class="fas fa-chevron-down sl-icon"></i>
        <i v-if="showClearBtn" class="far fa-times-circle sl-icon" @click.stop="onClear"></i>
      </template>
    </sl-input>
    <popper
      ref="popper"
      :selectedLabel="selectedLabel"
      :visible="visible"
      :options="filteredItems"
      :inputWidth="inputWidth"
      @select-option="onSelectOption">
    </popper>
  </div>
</template>

<script lang='ts'>
  import vClickOutside from 'v-click-outside'
  import { addResizeObserver } from '../../utils/resize_observer'
  import Input from './input.vue';
  import Popper from './popper.vue'
  import { Component, Prop, Vue, Watch } from 'vue-property-decorator'

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
    @Prop({ required: false, default: 'please select' }) private placeholder: string
    @Prop({ required: false, default: false }) private disabled: boolean
    @Prop({ required: false, default: false }) private filterable: boolean
    @Prop({ required: false, default: false }) private clearable: boolean

    private visible: boolean = false
    private tmpQuery: string = ''
    private query: string = ''
    private selectedLabel: string = ''
    private currentPlaceholder: string = ''
    private mousedownClass: string = ''
    private isInputHover: boolean = false
    private inputWidth: number = 0

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

    get showClearBtn() {
      return this.isInputHover && this.clearable && !this.disabled && !!this.value
    }

    get isReverse(): boolean {
      return this.visible
    }

    @Watch('value')
    private onChangeValue(val: Val): void {
      this.selectedLabel = this.getSelectedLabel(this.value)
      this.tmpQuery = this.selectedLabel
    }

    @Watch('visible')
    private onChangeVisible(isOpen: boolean): void {
      if (isOpen) {
        if (this.selectedLabel && this.filterable) {
          this.tmpQuery = ''
          this.currentPlaceholder = this.selectedLabel
        }
      } else {
        if (this.filterable) {
          this.tmpQuery = this.selectedLabel
          this.currentPlaceholder = this.placeholder
        }
      }
    }

    @Watch('tmpQuery')
    private onChangeTmpQuery(val: string): void {
      if (this.filterable) {
        this.query = this.visible ? this.tmpQuery : ''
      }
    }

    private created() {
      this.currentPlaceholder = this.placeholder
    }

    private mounted(): void {
      this.selectedLabel = this.getSelectedLabel(this.value)
      this.tmpQuery = this.selectedLabel
      addResizeObserver(document.querySelector('.sl-input-wrapper'), this.setInputWidth)
    }

    private setInputWidth(entry) {
      this.inputWidth = entry.contentRect.width
    }

    private onClickOutside(): void {
      this.visible = false
    }

    private isNotClickedDropdown(event: MouseEvent): boolean {
      const className = (event.target as HTMLElement).className
      if (event.type === 'mousedown') {
        this.mousedownClass = className
        return false
      } else {
        return !(
          this.mousedownClass.includes('sl-option-item') ||
          this.mousedownClass.includes('sl-option-wrapper') ||
          className.includes('sl-option-item') ||
          className.includes('sl-option-wrapper')
        )
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

    private onSelectOption(val: Val): void {
      console.log(val)
      this.visible = false
      this.onInput(val)
      if (val !== this.value) {
        this.onChange(val)
      }
    }

    private onClear(): void {
      console.log('clear')
      this.visible = false
      const val = ''
      this.onInput(val)
      this.$emit('clear')
    }

    private onInput(val: Val): void {
      this.$emit('input', val)
    }

    private onChange(val: Val): void {
      this.$emit('change', val)
    }

  }
</script>
