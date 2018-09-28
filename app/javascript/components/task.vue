<template>
  <div class='c-hand p-2 tile tile-centered task' :class="{ 'bg-gray': focussed, 'loading': editLoading }" @click="focusTask">
    <template v-if="editing">
      <div class="tile-content">
        <validation-errors
          item-type="task"
          :validation-errors="editValidationErrors"
          v-if="editValidationErrors.length" />
        <div class='form-group mt-1'>
          <input
            class='form-input'
            type='text'
            name='edit_task_title'
            placeholder="Task description"
            v-model="editedTitle" />
        </div>
        <div class='form-group'>
          <input
            class='form-input'
            type='text'
            name='edit_task_tags_list'
            placeholder="Tags list (comma separated)"
            v-model="editedTagsList" />
        </div>
      </div>
      <div class='tile-actions' key='edit-buttons'>
        <button
          class='btn btn-link tooltip tooltip-left'
          data-tooltip="Save Changes"
          @click.prevent="updateTask">
            <i class='icon icon-check'>Save</i>
        </button>
        <button
          class='btn btn-link tooltip tooltip-left'
          data-tooltip="Cancel Edit"
          @click.prevent="cancelEdit">
            <i class='icon icon-cross'>Cancel</i>
        </button>
      </div>
    </template>

    <template v-else>
      <div class='tile-content'>
        <div class='tile-title text-bold'>{{ title }}</div>
        <div class='text-subtitle mt-2'>
          <span class='label label-rounded' v-for="tag in tags" :key="tag">
            {{ tag }}
          </span>
        </div>
      </div>
      <div class='tile-actions' key='view-buttons'>
        <button
          class='btn btn-link tooltip tooltip-left'
          data-tooltip="Edit Task"
          @click.prevent="startEdit">
            <i class='icon icon-edit'>Edit</i>
        </button>
        <button
          class='btn btn-link tooltip tooltip-left'
          data-tooltip="Delete Task"
          @click.prevent="deleteTask">
            <i class='icon icon-delete'>Delete</i>
        </button>
      </div>
    </template>
  </div>
</template>

<script>

import axios from '../utils/request'
import ValidationErrors from './validation_errors.vue'

export default {
  props: {
    id: Number,
    title: String,
    tags: Array,
    focussed: Boolean
  },
  data: function() {
    return {
      editing: false,
      editLoading: false,
      editedTitle: this.title,
      editedTagsList: this.tags.join(', '),
      editValidationErrors: []
    }
  },
  methods: {
    /**
     * Make a request to delete this task, then emit a remove-task event with
     * the task ID
     *
     * @fires remove-task
     */
    deleteTask: function() {
      const vm = this;

      axios.delete(`/tasks/${this.id}`)
        .then(function(response){
          vm.$emit('remove-task', vm.id);
        });
    },
    /**
     * Call to put the task in an editable state
     */
    startEdit: function() {
      this.editing = true;
    },
    /**
     * Call to put the task in in a read state
     */
    cancelEdit: function() {
      this.editing = false;
    },
    /**
     * Sends an event to specify that this task should be focussed
     *
     * @fires focus-task
     */
    focusTask: function() {
      this.$emit('focus-task', this.id);
    },
    /**
     * Makes a request to update this task according to the editable form,
     * then fires an updated-task event with the new task data
     *
     * @fires update-task
     */
    updateTask: function() {
      this.editLoading = true;

      const vm = this;
      const url = `/tasks/${this.id}`;
      const payload = {
        task: {
          title: this.editedTitle,
          tags_list: this.editedTagsList
        }
      };

      axios.patch(url, payload)
        .then(function(xhr) {
          // On success emit the update-task event, set editing to false nad
          // reset any validation errors
          vm.$emit('update-task', xhr.data);
          vm.editing = false;
          vm.editValidationErrors = [];
        })
        .catch(function(error) {
          // Display any validation errors on 422 or raise an alert
          if(error.response.status === 422){
            vm.editValidationErrors = error.response.data;
          } else {
            alert("Sorry, an unknown error occurred");
          }
        })
        .then(function() {
          // Always set loading state to false
          vm.editLoading = false;
        });
    }
  },
  components: {
    'validation-errors': ValidationErrors
  }
}
</script>
