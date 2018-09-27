<template>
  <form @submit.prevent="addComment">
    <textarea
      v-model="body"
      class="form-input"
      placeholder="Enter your comment here. Markdown is allowed.">
    </textarea>
    <button type="submit" class="btn btn-primary btn-block" :class="loadingClass">Post Comment</button>
  </form>
</template>

<script>
import axios from '../utils/request';

function getInitialData() {
  return {
    body: '',
    loading: false
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
