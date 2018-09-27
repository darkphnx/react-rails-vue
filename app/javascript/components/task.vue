<template>
  <div class='c-hand p-2 tile tile-centered task' :class="focussedClass" @click="focusTask">
    <div class='tile-content'>
      <div class='tile-title text-bold'>{{ title }}</div>
      <div class='text-subtitle mt-2'>
        <span class='label label-rounded' v-for="tag in tags" :key="tag">
          {{ tag }}
        </span>
      </div>
    </div>
    <div class='tile-actions'>
      <button
        class='btn btn-link tooltip tooltip-left'
        data-tooltip="Delete Task"
        v-on:click.prevent="deleteTask">
          <i class='icon icon-delete'></i>
      </button>
    </div>
  </div>
</template>

<script>

import axios from '../utils/request'

export default {
  props: {
    id: Number,
    title: String,
    tags: Array,
    focussed: Boolean
  },
  methods: {
    deleteTask: function() {
      const vm = this;

      axios.delete(`/tasks/${this.id}`)
        .then(function(response){
          vm.$emit('remove-task', vm.id);
        });
    },
    focusTask: function() {
      this.$emit('focus-task', this.id);
    }
  },
  computed: {
    focussedClass: function() {
      if(this.focussed){
        return 'bg-gray';
      }
    }
  }

}
</script>
