<template>
  <div>
    <a
      href='#'
      class='label label-rounded'
      :class="allTagClass()"
      @click.prevent="clearTagFilters">
        All Tags
    </a>
    <a
      href='#'
      class='label label-rounded'
      :class="tagClass(tag)"
      v-for="tag in tags"
      :key="tag"
      @click.prevent="toggleTagFilter(tag)">
        {{ tag }}
    </a>
  </div>
</template>

<script>
  export default {
    props: {
      tags: Array,
      selectedTags: Array
    },
    methods: {
      clearTagFilters: function() {
        this.$emit('update-selected-tags', []);
      },
      toggleTagFilter: function(tag) {
        const currentSelectedTags = this.selectedTags;
        const tagIndex = currentSelectedTags.indexOf(tag);

        if(tagIndex >= 0){
          // Remove tag if it's in the selected list
          currentSelectedTags.splice(tagIndex, 1);
        } else {
          // Add tag if it isn't present in the list
          currentSelectedTags.push(tag)
        }

        this.$emit('update-selected-tags', currentSelectedTags);
      },
      tagClass: function(tag) {
        if(this.selectedTags.includes(tag)){
          return 'label-primary';
        }
      },
      allTagClass: function() {
        if(this.selectedTags.length === 0){
          return 'label-primary';
        }
      }
    }

  }
</script>
