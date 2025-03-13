<template>
  <NuxtLink :to="`/tags/${tag.slug}`" class="block bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow p-4">
    <h3 class="font-medium text-gray-900">{{ tag.name }}</h3>
    <p v-if="tag.description" class="text-sm text-gray-500 mt-1 line-clamp-2">{{ tag.description }}</p>
  </NuxtLink>
</template>

<script setup>
defineProps({
  tag: {
    type: Object,
    required: true
  }
});
</script>
