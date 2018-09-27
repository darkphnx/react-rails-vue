<template>
  <form @submit.prevent="addTask">
    <validation-errors
      item-type="task"
      :validation-errors="validationErrors"
      v-if="validationErrors.length" />
    <div class='form-group mt-1'>
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
import ValidationErrors from './validation_errors.vue'

function getInitialData() {
  return {
    title: '',
    tags_list: '',
    loading: false,
    validationErrors: []
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
        })
        .catch(function(error) {
          if(error.response.status === 422){
            vm.validationErrors = error.response.data;
          } else {
            alert("Sorry, an unknown error occurred");
          }
        })
        .then(function() {
          vm.loading = false;
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
  },
  components: {
    'validation-errors': ValidationErrors
  }
}
</script>
