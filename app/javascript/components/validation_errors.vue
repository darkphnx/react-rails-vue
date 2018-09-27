<template>
  <div class='toast toast-error'>
    <h6>Sorry, couldn't save that {{ itemType }}, the following errors occurred:</h6>
    <ul>
      <li v-for="(error, i) in validationErrors" :key="i">
        {{ error }}
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  props: {
    itemType: String,
    validationErrors: Array,
  },
  data: function() {
    return {
      itemType: 'item'
    }
  }
}
</script>
