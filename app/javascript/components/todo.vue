<template>
  <div class='columns'>
    <div class='column col-6'>
      <div class='panel'>
        <div class='panel-header'>
          <div class='panel-title h5 mt-10'>Tasks</div>
        </div>
        <div class='panel-body'>
          <span class='label label-rounded label-primary'>All Tags</span>
        </div>
        <div class='panel-body'>
          <template v-if="anyTasks">
            <task
              v-for="task in tasks"
              v-bind="task"
              :key="task.id"
              @remove-task="removeTask" />
          </template>
          <template v-else>
            <empty
              icon="flag"
              title="No tasks yet"
              subtitle="Add one with the form below" />
          </template>
        </div>
        <div class='panel-footer'>
          <new-task-form @add-task="addTask" />
        </div>
      </div>
    </div>
    <div class='column col-6'>
      <div class='panel'>
        <div class='panel-header'>
          <div class='panel-title h5 mt-10'>Comments</div>
        </div>
        <div class='panel-body'>
          <empty
            icon="message"
            title="No comments yet"
            subtitle="Add one with the form below" />
        </div>
        <div class='panel-footer'>
          New comment form
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Task from './task.vue'
import NewTaskForm from './new_task_form.vue'
import Empty from './empty'
import axios from '../utils/request'

export default {
  data: function () {
    return {
      tasks: []
    }
  },
  created: function() {
    this.fetchTasks()
  },
  methods: {
    fetchTasks: function() {
      const vm = this;

      axios.get('/tasks')
        .then(function(xhr) {
          vm.tasks = xhr.data;
        });
    },
    addTask: function(newTask) {
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
  computed: {
    anyTasks: function() {
      return this.tasks.length;
    }
  },
  components: {
    'task': Task,
    'new-task-form': NewTaskForm,
    'empty': Empty
  }
}
</script>
