<template>
  <form @submit.prevent="addComment">
    <textarea
      v-model="body"
      class="form-input"
      placeholder="Enter your comment here. Markdown is allowed.">
    </textarea>
    <button type="submit" class="btn btn-primary btn-block">Post Comment</button>
  </form>
</template>

<script>
  import axios from '../utils/request';

  export default {
    props: {
      taskId: Number
    },
    data: function() {
      return {
        body: ''
      }
    },
    methods: {
      addComment: function() {
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
          });
      }
    }
  }
</script>
