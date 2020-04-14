<style>
  #tooltip {
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

  #tooltip[data-popper-placement^='top'] > #arrow {
    bottom: -4px;
  }

  #tooltip[data-popper-placement^='bottom'] > #arrow {
    top: -4px;
  }

  #tooltip[data-popper-placement^='left'] > #arrow {
    right: -4px;
  }

  #tooltip[data-popper-placement^='right'] > #arrow {
    left: -4px;
  }

  #tooltip {
    display: none;
  }

  #tooltip[data-show] {
    display: block;
  }
</style>

<template>
  <div id="tooltip" role="tooltip">
    <select-option v-for="option in options" :key="option.value" :value="option.value" :label="option.label" @select-option="onChange"></select-option>
    <div id="arrow" data-popper-arrow></div>
  </div>
</template>

<script lang="ts">
  import axios from 'axios';
  import SelectOption from './option.vue'
  import { createPopper } from '@popperjs/core'
  import { Component, Prop, Vue, Watch } from 'vue-property-decorator';

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

    private button: any = {}
    private tooltip: any = {}

    private options: { label: string, value: number }[] = [
      { label: "one", value: 1 },
      { label: "two", value: 2 },
      { label: "three", value: 3 },
      { label: "four", value: 4 },
      { label: "five", value: 5 },
      { label: "six", value: 6 },
      { label: "seven", value: 7 },
      { label: "eight", value: 8 },
      { label: "nine", value: 9 },
      { label: "ten", value: 10 }
    ]

    @Watch('visible')
    onChangeVisible(val: boolean) {
      if (val) {
        this.show()
        createPopper(this.button, this.tooltip, {
          modifiers: [
            {
              name: 'offset',
              options: {
                offset: [0, 8],
              },
            },
          ],
        });
      } else {
        this.hide()
      }
    } 

    private mounted() {
      this.button = this.$parent.$refs.reference.$el
      this.tooltip = this.$el
    }

    private show() {
      document.body.appendChild(this.tooltip)
      this.tooltip.setAttribute('data-show', '');
    }

    private hide() {
      this.tooltip.removeAttribute('data-show');
    }

    private onChange() {
      console.log("click")
    }
  }
</script>
