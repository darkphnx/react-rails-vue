<template>
  <div>
    <ul>
      <task
        v-for="task in tasks"
        v-bind="task"
        :key="task.id"
        @remove-task="removeTask" />
    </ul>
    <new-task-form @add-task="addTask" />
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
    addTask: function (newTask) {
      this.tasks.push(newTask);
    },
    removeTask: function(taskId) {
      const taskIndex = this.tasks.findIndex(function(task){
        return task.id === taskId;
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
