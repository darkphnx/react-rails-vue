<template>
  <form @submit.prevent="addTask">
    <h2>Add Task</h2>
    <input type='text' v-model="title" placeholder="Description" />
    <input type='text' v-model="tags_list" placeholder="Tags List" />
    <button type='submit'>Add Task</button>
  </form>
</template>

<script>
import axios from '../utils/request'

function getInitialData() {
  return {
    title: '',
    tags_list: ''
  }
}

export default {
  data: getInitialData,
  methods: {
    addTask: function() {
      const vm = this;
      const payload = {
        task: {
          title: this.title,
          tags_list: this.tags_list
        }
      };

      axios.post("/tasks", payload)
        .then(function (newTask) {
          vm.$emit('add-task', newTask.data);
          vm.resetData();
        });
    },
    resetData: function() {
      Object.assign(this.$data, getInitialData());
    }
  }
}
</script>
