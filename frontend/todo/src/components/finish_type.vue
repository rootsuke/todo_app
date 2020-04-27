<template>
  <div>
    <p>{{local_val}}</p>
    <el-select :value="local_val" @change="onChange"  placeholder="Select" style="margin-bottom:20px;">
      <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value"></el-option>
    </el-select>
    <sl-select :value="local_val" :options="options" @change="onChange"></sl-select>
  </div>
</template>

<script lang='ts'>
  import axios from 'axios'
  import SlSelect from './select/select.vue'
  import { Select, Option } from 'element-ui'
  import { Prop, Component, Vue, Emit } from 'vue-property-decorator';

  interface Response {
    data: {
      info: {
        finish_type: number,
      },
    },
  }

  @Component({
    components: {
      'el-select': Select,
      'el-option': Option,
      'sl-select': SlSelect,
    },
  })
  export default class FinishType extends Vue {
    @Prop({ required: true }) private value!: number
    @Prop({ required: true }) private taskId!: number

    private options: Array<{ label: string, value: number }> = [
      { label: "one", value: 1 },
      { label: "two", value: 2 },
      { label: "three", value: 3 },
      { label: "four", value: 4 },
      { label: "five", value: 5 },
      { label: "six", value: 6 },
      { label: "seven", value: 7 },
      { label: "eight", value: 8 },
      { label: "nine", value: 9 },
      { label: "ten", value: 10 },
    ]

    get local_val() { return this.value }
    set local_val(val) { this.onChange(val) }

    private onChange(val: number): void {
      console.log(val)
      const url = '/api/v1/is_finish_tasks'
      const params = { task_id: this.taskId, finish_type: val }
      axios
        .put(url, params)
        .then(this.onSuccess)
        .catch(this.onError)
    }

    private onSuccess(res: Response): void {
      this.$notify({
        title: '更新成功',
        message: '更新しました',
        duration: 2000,
        position: 'top-left',
        type: 'success',
      })
      this.input(res.data.info.finish_type)
    }

    private onError(): void {
      this.$notify({
        title: '更新失敗',
        message: '更新に失敗しました',
        duration: 2000,
        position: 'top-left',
        type: 'error',
      })
    }

    @Emit('input')
    private input(val: number): number { return val }
  }
</script>
