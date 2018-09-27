<template>
  <li>
    <h3>{{ title }}</h3>
    <ul>
      <li><a href="#" v-on:click.prevent="editable">Edit</a></li>
      <li><a href="#" v-on:click.prevent="deleteTask">Delete</a></li>
    </ul>
  </li>
</template>

<script>

import axios from '../utils/request'

export default {
  props: ['id', 'title'],
  methods: {
    deleteTask: function() {
      const vm = this;

      axios.delete(`/tasks/${this.id}`)
        .then(function(response){
          vm.$emit('remove-task', vm.id);
        });
    }
  }

}
</script>
