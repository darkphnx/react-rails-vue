<template>
  <div class='tile tile-centered mt-2 comment'>
    <div class='tile-content'>
      <div class='tile-title markdown' v-html="body_html"></div>
      <div class='text-subtitle text-italic text-gray'>Posted {{ created_at }} </div>
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
