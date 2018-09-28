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
    /**
     * CSS classes to use for the icon. Uses the icon prop to pick from the
     * list at https://picturepan2.github.io/spectre/elements.html#icons
     *
     * @returns {String[]} Array of css classes
     */
    iconClasses: function (){
      const iconClass = `icon-${this.icon}`;
      return ['icon', iconClass];
    }
  }
}
</script>
