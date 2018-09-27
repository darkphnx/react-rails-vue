<template>
  <form @submit.prevent="addComment">
    <validation-errors
      item-type="comment"
      :validation-errors="validationErrors"
      v-if="validationErrors.length" />
    <textarea
      v-model="body"
      class="form-input mt-1"
      placeholder="Enter your comment here. Markdown is allowed.">
    </textarea>
    <button type="submit" class="btn btn-primary btn-block" :class="loadingClass">Post Comment</button>
  </form>
</template>

<script>
import axios from '../utils/request';
import ValidationErrors from './validation_errors.vue'

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
          vm.$emit('update-task', xhr.data);
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
    },
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
