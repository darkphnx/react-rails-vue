<template>
  <div class='columns'>
    <div class='column col-6'>
      <div class='panel'>
        <div class='panel-header'>
          <div class='panel-title h5 mt-10'>Tasks</div>
        </div>
        <div class='panel-body'>
          <tag-filter
            :tags="availableTags"
            :selectedTags="selectedTags"
            @update-selected-tags="updateSelectedTags" />
        </div>
        <div class='panel-body'>
          <template v-if="anyTasks">
            <task
              v-for="task in filteredTasks"
              v-bind="task"
              :key="task.id"
              :focussed="focussedTask === task"
              @remove-task="removeTask"
              @focus-task="focusTask" />
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
          <template v-if="focussedTask === null">
            <empty
              icon="message"
              title="No task selected"
              subtitle="Select a task from the list on the left to show it's comments" />
          </template>
          <template v-else-if="focussedTask.comments.length === 0">
            <empty
              icon="message"
              title="No comments yet"
              subtitle="Add one with the form below" />
          </template>
          <template v-else>
            <comment
              v-for="comment in focussedTask.comments"
              :key="comment.id"
              v-bind='comment' />
          </template>
        </div>
        <div class='panel-footer'>
          New comment form
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import TagFilter from './tag_filter.vue'
import Task from './task.vue'
import NewTaskForm from './new_task_form.vue'
import Comment from './comment.vue'
import Empty from './empty'

import axios from '../utils/request'

export default {
  data: function () {
    return {
      tasks: [],
      focussedTask: null,
      selectedTags: [],
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
      const taskIndex = this.tasks.findIndex(function(task) {
        return task.id === taskId;
      });

      this.tasks.splice(taskIndex, 1);
    },
    focusTask: function(taskId) {
      this.focussedTask = this.tasks.find(function(task) {
        return task.id === taskId;
      })
    },
    updateSelectedTags: function(newSelectedTags){
      this.selectedTags = newSelectedTags;
    }
  },
  computed: {
    anyTasks: function() {
      return this.tasks.length;
    },
    availableTags: function() {
      const availableTags = [];

      // Add any tags from tasks into availableTags
      this.tasks.forEach(function(task) {
        task.tags.forEach(function(tag) {
          // Push the tag onto available tags if it's not currently present
          if(!availableTags.includes(tag)){
            availableTags.push(tag);
          }
        })
      });

      return availableTags;
    },
    filteredTasks: function() {
      if(this.selectedTags.length == 0){
        return this.tasks;
      } else {
        const vm = this;

        const matchingTasks = this.tasks.filter(function(task) {
          const foundTagIndex = task.tags.findIndex(function(tag) {
            return vm.selectedTags.includes(tag);
          });

          return foundTagIndex >= 0;
        });

        return matchingTasks;
      }
    }
  },
  components: {
    'tag-filter': TagFilter,
    'task': Task,
    'new-task-form': NewTaskForm,
    'comment': Comment,
    'empty': Empty
  }
}
</script>
