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
</style>

<template>
  <div class="sl-dropdown" role="tooltip">
    <select-option v-for="option in options" :key="option.value" :value="option.value" :label="option.label" @select-option="onSelectOption"></select-option>
    <div id="arrow" data-popper-arrow></div>
  </div>
</template>

<script lang="ts">
  import axios from 'axios';
  import SelectOption from './option.vue'
  import { createPopper } from '@popperjs/core'
  import { Component, Emit, Prop, Vue, Watch } from 'vue-property-decorator';

  interface Response {
    data: {
      info: object[],
    }
  }

  @Component({
    components: {
      'select-option': SelectOption,
    }
  })
  export default class Popper extends Vue {
    @Prop({ required: true }) visible: boolean
    @Prop({ required: true }) options: { label: string, value: string | number | boolean }[]

    private button: any = {}
    private dropdown: any = {}

    private existsPopper: boolean = false

    @Watch('visible')
    onChangeVisible(val: boolean) {
      if (val) {
        if (!this.existsPopper) {
          this.onCreatePopper()
        }
        this.show()
      } else {
        this.hide()
      }
    } 

    private mounted() {
    }

    onCreatePopper() {
      this.button = this.$parent.$refs.reference.$el
      this.dropdown = this.$el
      createPopper(this.button, this.dropdown, {
        modifiers: [
          {
            name: 'offset',
            options: {
              offset: [0, 8],
            },
          },
        ],
      })
      document.body.appendChild(this.dropdown)
      this.existsPopper = true
    }

    private show() {
      this.dropdown.setAttribute('data-show', '');
    }

    private hide() {
      this.dropdown.removeAttribute('data-show');
    }

    @Emit('select-option')
    private onSelectOption(val) {
      console.log("click")
      return val
    }
  }
</script>
