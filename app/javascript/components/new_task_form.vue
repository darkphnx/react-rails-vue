<template>
  <form @submit.prevent="addTask" id='new_task_form'>
    <validation-errors
      item-type="task"
      :validation-errors="validationErrors"
      v-if="validationErrors.length" />
    <div class='form-group mt-1'>
      <input
        class='form-input'
        type='text'
        placeholder="Task description"
        name="task_title"
        v-model="title" />
    </div>
    <div class='form-group'>
      <div class='input-group'>
        <input
          class='form-input'
          type='text'
          placeholder="Tags list (comma separated)"
          name="task_tags_list"
          v-model="tags_list" />
        <button
          type="submit"
          class='btn btn-primary input-group-btn'
          :class="{ 'loading': loading }">
            Add Task
        </button>
      </div>
    </div>
  </form>
</template>

<script>
import axios from '../utils/request'
import ValidationErrors from './validation_errors.vue'

/**
 * Initial form data. We have this in a separate function so that we can call
 * it again later to reset the form
 *
 * @returns {Object}
 */
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
    /**
     * Posts a task to the backend using axios, emits an add-task event
     * on success with an json version of the new task.
     *
     * @fires add-task
     */
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
          // On success emit an add-task event with the task data and reset
          // the form.
          vm.$emit('add-task', newTask.data);
          vm.resetData();
        })
        .catch(function(error) {
          // Display validation errors if we receive a 422, or raise an alert
          if(error.response.status === 422){
            vm.validationErrors = error.response.data;
          } else {
            alert("Sorry, an unknown error occurred");
          }
        })
        .then(function() {
          // Always set loading to false
          vm.loading = false;
        });
    },
    /**
     * Reset form data back to default state
     */
    resetData: function() {
      Object.assign(this.$data, getInitialData());
    }
  },
  components: {
    'validation-errors': ValidationErrors
  }
}
</script>
