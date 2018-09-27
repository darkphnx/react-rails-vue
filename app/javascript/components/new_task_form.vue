<template>
  <form @submit.prevent="addTask">
    <div class='form-group'>
      <input class='form-input' type='text' v-model="title" placeholder="Task" />
    </div>
    <div class='form-group'>
      <div class='input-group'>
        <input class='form-input' type='text' v-model="tags_list" placeholder="Tags List" />
        <button class='btn btn-primary input-group-btn' type='submit'>Add Task</button>
      </div>
    </div>
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
