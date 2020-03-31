<style lang='scss'>
  .option-item {
    list-style: none;
    cursor: pointer;
    &:hover {
      background: azure;
    }
  }
</style>

<template>
  <div>
    <input v-model="query" type="text">
    <ul>
      <li v-for="item in filteredItems" :key="item.value" :value="item.value" @click="onChange($event.target.value)" class="option-item">{{ item.label }}</li>
    </ul>
    <p>{{local_val}}</p>
    <el-select v-model="local_val" filterable placeholder="Select">
      <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value"></el-option>
    </el-select>
  </div>
</template>

<script lang='ts'>
  import axios from 'axios'
  import { Select, Option } from 'element-ui'
  import { Prop, Component, Vue, Emit } from 'vue-property-decorator';

  @Component({
    components: {
      'el-select': Select,
      'el-option': Option,
    }
  })
  export default class FinishType extends Vue {
    @Prop({ required: true }) private value!: number
    @Prop({ required: true }) private task_id!: number

    private prev = 1
    private query:string = ""

    get regexp() { return new RegExp(`.*${this.query}.*`, 'g') }

    get filteredItems() {
      return this.options.filter((option) => option.label.match(this.regexp))
    }

    get local_val() { return this.value }
    set local_val(val) { this.input(val) }

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

    private onChange(val: number): void {
      const url = '/api/v1/is_finish_tasks'
      const params = { task_id: this.task_id, finish_type: val }
      axios
        .put(url, params)
        .then(this.onSuccess)
        .catch(this.onError)
    }

    private onSuccess(res): void {
      console.log("success", res)
      this.$notify({
        title: '更新成功',
        message: '更新しました',
        duration: 2000,
        position: 'top-left',
        type: 'success',
      })
      this.input(res.data.info.finish_type)
    }

    private onError(err): void {
      console.log("error", err)
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
