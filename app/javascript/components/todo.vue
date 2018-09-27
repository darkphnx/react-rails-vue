<template>
  <div>
    <button v-on:click="addTask">Add Task!</button>
    <task-list :tasks="tasks" />
  </div>
</template>

<script>
import TaskList from './task_list.vue'
import NewTaskForm from './new_task_form.vue'

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
    },
    deleteTask: function() {

    },
    updateTask: function() {

    }
  },
  components: {
    'task-list': TaskList,
    'new-task-form': NewTaskForm
  }
}
</script>
