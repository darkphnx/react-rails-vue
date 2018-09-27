<template>
  <div class='empty'>
    <div class='empty-icon'>
      <i :class='iconClasses'></i>
    </div>
    <p class='empty-title h5'>{{ title }}</p>
    <p class='empty-subtitle'>{{ subtitle }}</p>
  </div>
</template>

<script>
export default {
  props: {
    icon: String,
    title: String,
    subtitle: String
  },
  computed: {
    iconClasses: function (){
      const iconClass = `icon-${this.icon}`;
      return ['icon', iconClass];
    }
  }
}
</script>
