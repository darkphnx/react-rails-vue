<template>
  <div id='tag_filter'>
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
      /**
       * Unset any current tag filters by emitting update-selected-tags with
       * an empty array
       *
       * @fires update-selected-tags
       */
      clearTagFilters: function() {
        this.$emit('update-selected-tags', []);
      },
      /**
       * Turn a tag filter on or off depending on it's current state. Emits
       * an update-selected-tags event with the new tag list
       *
       * @fires update-selected-tags
       */
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
      /**
       * @returns {String} A label-primary tag if given tag is active
       */
      tagClass: function(tag) {
        if(this.selectedTags.includes(tag)){
          return 'label-primary';
        }
      },
      /**
       * @returns {String} A label-primary tag if no tags are active
       */
      allTagClass: function() {
        if(this.selectedTags.length === 0){
          return 'label-primary';
        }
      }
    }

  }
</script>
