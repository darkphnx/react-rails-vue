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
export default {
  props: ['id', 'title'],
  methods: {
    deleteTask: function() {
      console.log(this.id)
    }
  }

}
</script>
