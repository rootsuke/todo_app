<style>
  .sl-dropdown {
    background: #333;
    color: white;
    font-weight: bold;
    padding: 4px 8px;
    font-size: 13px;
    border-radius: 4px;
  }
  #arrow,
  #arrow::before {
    position: absolute;
    width: 8px;
    height: 8px;
    z-index: -1;
  }

  #arrow::before {
    content: '';
    transform: rotate(45deg);
    background: #333;
  }

  .sl-dropdown[data-popper-placement^='top'] > #arrow {
    bottom: -4px;
  }

  .sl-dropdown[data-popper-placement^='bottom'] > #arrow {
    top: -4px;
  }

  .sl-dropdown[data-popper-placement^='left'] > #arrow {
    right: -4px;
  }

  .sl-dropdown[data-popper-placement^='right'] > #arrow {
    left: -4px;
  }

  .sl-dropdown {
    display: none;
  }

  .sl-dropdown[data-show] {
    display: block;
  }

  .empty-text {
    list-style: none;
  }
</style>

<template>
  <div class="sl-dropdown" role="tooltip">
    <select-option v-for="option in options" :key="option.value" :value="option.value" :label="option.label" @select-option="onSelectOption"></select-option>
    <li v-show="isOptionsEmpty" class="empty-text">no data matches.</li>
    <div id="arrow" data-popper-arrow></div>
  </div>
</template>

<script lang="ts">
  import axios from 'axios';
  import SelectOption from './option.vue'
  import { createPopper } from '@popperjs/core'
  import { Component, Emit, Prop, Vue, Watch } from 'vue-property-decorator';

  type Val = string | number | boolean;
  interface Response {
    data: {
      info: object[],
    },
  }

  @Component({
    components: {
      'select-option': SelectOption,
    },
  })
  export default class Popper extends Vue {
    @Prop({ required: true }) private visible: boolean
    @Prop({ required: true }) private options: Array<{ label: string, value: string | number | boolean }>

    private reference: any = {}
    private dropdown: any = {}
    private popperInstance: any = {}

    private existsPopper: boolean = false

    get isOptionsEmpty() {
      return this.options.length === 0
    }

    @Watch('options')
    private onChangeOptions(): void {
      if (this.existsPopper) {
        this.popperInstance.update()
      }
    }

    @Watch('visible')
    private onChangeVisible(val: boolean): void {
      if (val) {
        if (!this.existsPopper) {
          this.onCreatePopper()
        }
        this.show()
      } else {
        this.hide()
      }
    }

    private onCreatePopper(): void {
      const reference = this.$parent.$refs.reference as Vue
      this.reference = reference.$el
      this.dropdown = this.$el
      this.popperInstance = createPopper(this.reference as Element, this.dropdown as HTMLElement, {
        modifiers: [
          {
            name: 'offset',
            options: {
              offset: [0, 8],
            },
          },
        ],
      })
      this.existsPopper = true
      document.body.appendChild(this.dropdown)
    }

    private show(): void {
      this.popperInstance.update()
      this.dropdown.setAttribute('data-show', '');
    }

    private hide(): void {
      this.dropdown.removeAttribute('data-show');
    }

    @Emit('select-option')
    private onSelectOption(val: Val): Val {
      console.log("click")
      return val
    }
  }
</script>
