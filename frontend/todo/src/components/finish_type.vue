<template>
  <div>
    <select name="finish_type" v-model="local_val" @change="onChange($event.target.value)">
      <option disabled value="">Please select one</option>
      <option :value="1">1</option>
      <option :value="2">2</option>
      <option :value="3">3</option>
    </select>
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

    get local_val() { return this.value }
    set local_val(val) { this.input(val) }

    private options: object[] = [
      { label: "1", value: 1 },
      { label: "2", value: 2 },
      { label: "3", value: 3 }
    ]

    private onChange(val: number): void {
      const url = '/api/v1/is_finish_tasks'
      const params = { task_id: this.task_id, finish_type: val }
      axios
        .put(url, params)
        .then(this.onSuccess)
        .catch(this.onError)
    }

    private onSuccess(res): void { console.log("success", res); }

    private onError(err): void { console.log("error", err); this.rollback() }

    @Emit('input')
    private input(val: number): number { return val }

    @Emit('input')
    private rollback(): number { 
      this.prev = this.value
      return this.prev
    }

    private prevent(event) { event.preventDefault() }
  }
</script>
