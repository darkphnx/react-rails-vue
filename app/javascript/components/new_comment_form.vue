<template>
  <form @submit.prevent="addComment" id='new_comment_form'>
    <validation-errors
      item-type="comment"
      :validation-errors="validationErrors"
      v-if="validationErrors.length" />
    <textarea
      v-model="body"
      class="form-input mt-1"
      name='comment_body'
      placeholder="Enter your comment here. Markdown is allowed.">
    </textarea>
    <button
      type="submit"
      class="btn btn-primary btn-block"
      :class="{ 'loading': loading }">
        Post Comment
    </button>
  </form>
</template>

<script>
import axios from '../utils/request';
import ValidationErrors from './validation_errors.vue'

/**
 * Initial form data. We have this in a separate function so that we can call
 * it again later to reset the form
 *
 * @returns {Object}
 */
function getInitialData() {
  return {
    body: '',
    loading: false,
    validationErrors: []
  }
}

export default {
  props: {
    taskId: Number
  },
  data: getInitialData,
  methods: {
    /**
     * Posts a comment to the backend using axios, emits an update-task event
     * on success with an updated version of the task.
     *
     * @fires update-task
     */
    addComment: function() {
      this.loading = true;

      const vm = this;
      const url = `/tasks/${this.taskId}/comments`;
      const payload = {
        comment: {
          body: this.body
        }
      }

      axios.post(url, payload)
        .then(function(xhr) {
          // On success emit update-task with refresh task data
          vm.$emit('update-task', xhr.data);
          vm.resetData();
        })
        .catch(function(error) {
          // On failure render validation errors if it's a 422, otherwise
          // display an alert box
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
     * Reset all form data to default
     */
    resetData: function() {
      Object.assign(this.$data, getInitialData());
    },
  },
  components: {
    'validation-errors': ValidationErrors
  }
}
</script>
