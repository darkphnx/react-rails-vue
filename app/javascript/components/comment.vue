<template>
  <div class='tile tile-centered mt-2'>
    <div class='tile-content'>
      <div class='tile-title' v-html="body_html"></div>
      <div class='text-subtitle text-gray'>Posted at {{ created_at }} </div>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      body_html: String,
      created_at: String
    }
  }
</script>
