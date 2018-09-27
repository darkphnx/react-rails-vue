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

import axios from 'axios'

export default {
  props: ['id', 'title'],
  methods: {
    deleteTask: function() {
      axios.delete(`/tasks/${this.id}`)
        .then(function(response){
          this.$emit('removeTask', this.id);
        });

      this.$emit('remove-task', this.id);
    }
  }

}
</script>
