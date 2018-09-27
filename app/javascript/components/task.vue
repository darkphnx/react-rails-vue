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
            placeholder="Task description"
            v-model="editedTitle" />
        </div>
        <div class='form-group'>
          <input
            class='form-input'
            type='text'
            placeholder="Tags list (comma separated)"
            v-model="editedTagsList" />
        </div>
      </div>
      <div class='tile-actions' key='edit-buttons'>
        <button
          class='btn btn-link tooltip tooltip-left'
          data-tooltip="Save Changes"
          @click.prevent="updateTask">
            <i class='icon icon-check'></i>
        </button>
        <button
          class='btn btn-link tooltip tooltip-left'
          data-tooltip="Cancel Edit"
          @click.prevent="cancelEdit">
            <i class='icon icon-cross'></i>
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
            <i class='icon icon-edit'></i>
        </button>
        <button
          class='btn btn-link tooltip tooltip-left'
          data-tooltip="Delete Task"
          @click.prevent="deleteTask">
            <i class='icon icon-delete'></i>
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
    deleteTask: function() {
      const vm = this;

      axios.delete(`/tasks/${this.id}`)
        .then(function(response){
          vm.$emit('remove-task', vm.id);
        });
    },
    startEdit: function() {
      this.editing = true;
    },
    cancelEdit: function() {
      this.editing = false;
    },
    focusTask: function() {
      this.$emit('focus-task', this.id);
    },
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
          vm.$emit('update-task', xhr.data);
          vm.editing = false;
          vm.editValidationErrors = [];
        })
        .catch(function(error) {
          if(error.response.status === 422){
            vm.editValidationErrors = error.response.data;
          } else {
            alert("Sorry, an unknown error occurred");
          }
        })
        .then(function() {
          vm.editLoading = false;
        });
    }
  },
  components: {
    'validation-errors': ValidationErrors
  }
}
</script>
