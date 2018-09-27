<template>
  <div>
    <button v-on:click="addTask">Add Task!</button>
    <ul>
      <task
        v-for="task in tasks"
        v-bind="task"
        :key="task.id"
        @remove-task="removeTask" />
    </ul>
  </div>
</template>

<script>
import Task from './task.vue'
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
    removeTask: function(taskId) {
      const taskIndex = this.tasks.findIndex(function(task){
        task.id === taskId;
      });

      this.tasks.splice(taskIndex, 1);
    },
    updateTask: function() {

    }
  },
  components: {
    'task': Task,
    'new-task-form': NewTaskForm
  }
}
</script>
