<template>
  <div class="container mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold mb-6">Browse by Tags</h1>
    
    <div v-if="pending" class="flex justify-center py-8">
      <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary-600"></div>
    </div>
    
    <div v-else-if="tags.length === 0" class="text-center py-8 text-gray-500">
      No tags found
    </div>
    
    <div v-else class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
      <TagCard v-for="tag in tags" :key="tag.id" :tag="tag" />
    </div>
  </div>
</template>

<script setup>
// Use useFetch for SSR data fetching
const { data: tagsData, pending } = await useFetch('/api/tags');

// Computed property for tags
const tags = computed(() => tagsData.value || []);

// Set page title
useHead({
  title: 'Tags - UI Library Directory'
});
</script>
