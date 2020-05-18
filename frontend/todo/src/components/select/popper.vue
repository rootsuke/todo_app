<style lang='scss'>
  .sl-popper {
    box-sizing: border-box;
    background-color: white;
    color: #606266;
    border: 1px solid #E4E7ED;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
    border-radius: 4px;
  }

  .sl-popper-menu {
    overflow: hidden;
    position: relative;
  }

  .sl-option-wrapper {
    max-height: 260px;
    overflow-y: scroll;
    &::-webkit-scrollbar {
      display: none;
    }
    &:hover {
      &::-webkit-scrollbar {
        display: block;
        width: 6px;
      }
      &::-webkit-scrollbar-thumb {
        background-color: rgba(144, 147, 153, 0.3);
        border-radius: 4px;
        &:hover {
          background-color: rgba(144, 147, 153, 0.5);
        }
      }
    }
  }

  .sl-option-list {
    box-sizing: border-box;
    margin: 0;
    padding: 6px 0;
  }

  .arrow,
  .arrow::before {
    position: absolute;
    width: 8px;
    height: 8px;
    z-index: -1;
  }

  .arrow::before {
    content: '';
    transform: rotate(45deg);
    background-color: white;
  }

  .sl-popper[data-popper-placement^='top'] > .arrow {
    bottom: -4px;
  }

  .sl-popper[data-popper-placement^='bottom'] > .arrow {
    top: -4px;
  }

  .sl-popper[data-popper-placement^='left'] > .arrow {
    right: -4px;
  }

  .sl-popper[data-popper-placement^='right'] > .arrow {
    left: -4px;
  }

  .sl-popper {
    display: none;
  }

  .sl-popper[data-show] {
    display: block;
  }

  .empty-text {
    padding: 10px 0;
    margin: 0;
    text-align: center;
    color: #999;
    font-size: 14px;
  }
</style>

<template>
  <div role="tooltip" class="sl-popper" :style="{ minWidth: minWidth }">
    <div class="sl-popper-menu">
      <div ref="wrapper" class="sl-option-wrapper">
        <ul class="sl-option-list">
          <select-option
            v-for="option in options"
            :key="option.value"
            :value="option.value"
            :label="option.label"
            :selectedLabel="selectedLabel"
            :hoverLabel="hoverLabel"
            @select-option="onSelectOption"
            @hover-option="onHoverOption">
          </select-option>
          <li v-show="isOptionsEmpty" class="empty-text">no data matches.</li>
        </ul>
      </div>
    </div>
    <div class="arrow" data-popper-arrow></div>
  </div>
</template>

<script lang="ts">
  import SelectOption from './option.vue'
  import { Instance } from '@popperjs/core/lib/types'
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
    @Prop({ required: true }) private selectedLabel: string
    @Prop({ required: true }) private visible: boolean
    @Prop({ required: true }) private options: Array<{ label: string, value: string | number | boolean }>
    @Prop({ required: true }) private inputWidth: number

    private popper: HTMLElement
    private popperInstance: Instance

    private existsPopper: boolean = false
    private hoverLabel: string = ''

    get isOptionsEmpty() {
      return this.options.length === 0
    }

    get minWidth(): string {
      return this.inputWidth + 'px'
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
        if (this.selectedLabel) {
          this.hoverLabel = this.selectedLabel
        }
        if (!this.existsPopper) {
          this.onCreatePopper()
        }
        this.show()
        this.$nextTick(() => {
          this.scrollToSelected()
        })
      } else {
        this.hide()
      }
    }

    private onCreatePopper(): void {
      const reference = (this.$parent.$refs.reference as Vue).$el
      this.popper = this.$el as HTMLElement
      this.popperInstance = createPopper(reference, this.popper, {
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
      document.body.appendChild(this.popper)
    }

    private show(): void {
      this.popperInstance.update()
      this.popper.setAttribute('data-show', '');
    }

    private hide(): void {
      this.popper.removeAttribute('data-show');
    }

    private onHoverOption(label: string): void {
      this.hoverLabel = label
    }

    private scrollToSelected(): void {
      const menu = this.$refs.wrapper as HTMLElement
      if (!this.selectedLabel) {
        menu.scrollTop = 0
        return
      }

      const menuTop = menu.scrollTop
      const menuBottom = menuTop + menu.clientHeight

      const index = this.options.findIndex(option => option.label === this.selectedLabel)
      const selectedTop = 34 * index + 6
      const selectedBottom = selectedTop + 34

      if (selectedTop < menuTop) {
        menu.scrollTop = selectedTop
      } else if (selectedBottom > menuBottom) {
        menu.scrollTop = selectedBottom - menu.clientHeight
      }
    }

    @Emit('select-option')
    private onSelectOption(val: Val): Val {
      console.log("click")
      return val
    }
  }
</script>
