<template>
  <div class="tasks">
    <h2>ToDo一覧</h2>
    <el-table :data="tasks" style="width: 100%" border>
      <el-table-column prop="task_id" label="タスクID" width="180" sortable></el-table-column>
      <el-table-column prop="user_name" label="ユーザー名" width="180" sortable></el-table-column>
      <el-table-column prop="title" label="タイトル" sortable></el-table-column>
      <el-table-column prop="content" label="内容" sortable></el-table-column>
      <el-table-column prop="finish_type" label="属性" width="180" sortable></el-table-column>
    </el-table>
  </div>
</template>

<script lang="ts">
  import { Component, Prop, Vue } from 'vue-property-decorator';
  import { Table, TableColumn } from 'element-ui'

  @Component({
    components: {
      'el-table': Table,
      'el-table-column': TableColumn,
    }
  })
  export default class HelloWorld extends Vue {
    @Prop() private tasks!: object[]
  }
</script>
