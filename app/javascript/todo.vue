<template>
  <div class='columns'>
    <div class='column col-6'>
      <div class='panel'>
        <div class='panel-header'>
          <div class='panel-title h5 mt-10'><i class='icon icon-flag'></i> Tasks</div>
        </div>
        <div class='panel-body my-2'>
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
              @update-task="updateTask"
              @focus-task="focusTask" />
          </template>
          <template v-else>
            <empty
              icon="flag"
              title="No tasks yet"
              subtitle="Add one with the form below"
              :class="{'loading loading-lg':  tasksLoading}" />
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
          <div class='panel-title h5 mt-10'><i class='icon icon-message'></i> Comments</div>
        </div>
        <div class='panel-body'>
          <template v-if="focussedTask === undefined">
            <empty
              icon="message"
              title="No task selected"
              subtitle="Select a task from the list on the left to show its comments"
              :class="{'loading loading-lg':  tasksLoading}" />
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
          <new-comment-form
            v-if="focussedTask"
            :task-id="focussedTask.id"
            @update-task="updateTask" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import TagFilter from 'components/tag_filter.vue'
import Task from 'components/task.vue'
import NewTaskForm from 'components/new_task_form.vue'
import Comment from 'components/comment.vue'
import NewCommentForm from 'components/new_comment_form.vue'
import Empty from 'components/empty'

import axios from 'utils/request'

export default {
  data: function () {
    return {
      tasks: [],
      focussedTaskId: null,
      selectedTags: [],
      tasksLoading: true
    }
  },
  /**
   * On load call fetchTasks() to get our initial set of tasks
   */
  created: function() {
    this.fetchTasks()
  },
  methods: {
    /**
     * Get a list of tasks from the backend and set this.tasks to the returned
     * data.
     *
     * Focusses the first task in the returned list.
     */
    fetchTasks: function() {
      const vm = this;

      axios.get('/tasks')
        .then(function(xhr) {
          vm.tasks = xhr.data;
          vm.tasksLoading = false;
          if(vm.tasks.length) {
            vm.focussedTaskId = vm.tasks[0].id;
          }
        });
    },
    /**
     * Add a new task to the tasks array and focus it
     *
     * @param {Object} newTask Task to add to the array
     */
    addTask: function(newTask) {
      this.tasks.push(newTask);
      this.focussedTaskId = newTask.id;
    },
    /**
     * Find an existing task and replace it's data with a new set
     *
     * @param {Object} updatedTask task to replace the existing one
     */
    updateTask: function(updatedTask) {
      const taskId = updatedTask.id;

      // Find the current tasks position in the tasks array
      const existingTaskIndex = this.tasks.findIndex(function(task) {
        return task.id === taskId;
      });

      // Only replace an existing task
      if(existingTaskIndex >= 0) {
        // Replace the existing task with the new data
        this.tasks.splice(existingTaskIndex, 1, updatedTask);
      }
    },
    /**
     * Remove an existing task from the tasks array
     *
     * @param {Number} taskId ID of the task to remove
     */
    removeTask: function(taskId) {
      const taskIndex = this.tasks.findIndex(function(task) {
        return task.id === taskId;
      });

      // Only delete if we can find the task
      if(taskIndex >= 0) {
        this.tasks.splice(taskIndex, 1);
      }
    },
    /**
     * Focus a task in the interface
     *
     * @param {Number} taskId ID of the task to focus
     */
    focusTask: function(taskId) {
      this.focussedTaskId = taskId;
    },
    /**
     * Set the selected tags list to a new set of tags
     *
     * @param {String[]} newSelectedTags array of tags ot be active
     */
    updateSelectedTags: function(newSelectedTags){
      this.selectedTags = newSelectedTags;
    }
  },
  computed: {
    /**
     * Are there any tasks present in the tasks array?
     */
    anyTasks: function() {
      return this.tasks.length;
    },
    /**
     * Find a list of available tags by concatenating all the unique tags
     * currently present on tasks.
     *
     * @returns {String[]} an array containing all of the tags that are on tasks
     */
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
    /**
     * Filters out tasks by tag. Filtering is an OR operation, so a task will
     * match if it has ANY of the tags in the selectedTags array.
     *
     * @return {Object[]} An array of matched tasks
     */
    filteredTasks: function() {
      if(this.selectedTags.length == 0){
        // If there aren't any selectedTags then we want all tasks
        return this.tasks;
      } else {
        const vm = this;

        // Loop through the tasks, then inpsect the tags on each to see if
        // they have anything that is present in selectedTags
        const matchingTasks = this.tasks.filter(function(task) {
          const foundTagIndex = task.tags.findIndex(function(tag) {
            return vm.selectedTags.includes(tag);
          });

          // Returns true if a selectedTag was present in the task
          return foundTagIndex >= 0;
        });

        return matchingTasks;
      }
    },
    /**
     * Find the focussed task using focussedTaskId. Only looks in the list of
     * filteredTasks. So if the task isn't currently available in there it will
     * not be focussed.
     *
     * @returns {Object} task that should be focussed
     */
    focussedTask: function() {
      const vm = this;

      return this.filteredTasks.find(function(task) {
        return task.id === vm.focussedTaskId;
      });
    }
  },
  components: {
    'tag-filter': TagFilter,
    'task': Task,
    'new-task-form': NewTaskForm,
    'comment': Comment,
    'new-comment-form': NewCommentForm,
    'empty': Empty
  }
}
</script>
