<template>
  <div>
    <button v-on:click="addTask">Add Task!</button>
    <ul>
      <li>ts</li>
      <li v-for="task in tasks" :key="task.id">
        {{ task.title }}
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  props: {
    initialTasks: Array
  },
  data: function () {
    return {
      tasks: this.initialTasks
    }
  },
  methods: {
    addTask: function () {
      this.tasks.push({ id: 999, title: "Another task"})
    }
  }
}
</script>
