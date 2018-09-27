<template>
  <form @submit.prevent="addTask">
    <div class='form-group'>
      <input
        class='form-input'
        type='text'
        placeholder="Task description"
        v-model="title" />
    </div>
    <div class='form-group'>
      <div class='input-group'>
        <input
          class='form-input'
          type='text'
          placeholder="Tags list (comma separated)"
          v-model="tags_list" />
        <button
          type="submit"
          class='btn btn-primary input-group-btn'
          :class="loadingClass">
            Add Task
        </button>
      </div>
    </div>
  </form>
</template>

<script>
import axios from '../utils/request'

function getInitialData() {
  return {
    title: '',
    tags_list: '',
    loading: false
  }
}

export default {
  data: getInitialData,
  methods: {
    addTask: function() {
      this.loading = true;

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
  },
  computed: {
    loadingClass: function() {
      if(this.loading) {
        return 'loading';
      }
    }
  }
}
</script>
