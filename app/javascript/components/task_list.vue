<template>
  <ul>
    <task v-for="task in tasks" v-bind="task" :key="task.id"></task>
  </ul>
</template>

<script>
import Task from './task.vue'

export default {
  props: {
    tasks: Array
  },
  components: { 'task': Task }
}
</script>
