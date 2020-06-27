<template>
  <div id="base">
    <list :tasks="tasks" />
  </div>
</template>

<script lang="ts">
  import axios from 'axios';
  import { Component, Vue } from 'vue-property-decorator';
  import List from './list.vue';

  interface Response {
    data: {
      info: object[],
    }
  }

  @Component({
    components: {
      list: List,
    },
  })
  export default class Base extends Vue {

    private tasks: object[] = []

    private created() {
      this.onRead()
    }

    private onRead(): void {
      const url = '/api/v1/tasks'
      axios.get(url)
        .then(this.onSuccessHandler)
    }

    private onSuccessHandler(res: Response) {
      console.log(res.data.info)
      this.tasks = res.data.info
    }

  }
</script>
