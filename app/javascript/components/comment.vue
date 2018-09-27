<template>
  <div class='tile tile-centered mt-2'>
    <div class='tile-content'>
      <div class='tile-title'>{{ body }}</div>
      <div class='text-subtitle text-gray'>Posted at {{ created_at }} </div>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      body: String,
      created_at: String
    }
  }
</script>
