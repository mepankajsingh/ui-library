<template>
  <div class="container mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold mb-6">Browse by Tags</h1>
    
    <div v-if="loading" class="flex justify-center py-8">
      <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary-600"></div>
    </div>
    
    <div v-else-if="tags.length === 0" class="text-center py-8 text-gray-500">
      No tags found
    </div>
    
    <div v-else class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-4">
      <TagCard v-for="tag in tags" :key="tag.id" :tag="tag" />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';

const loading = ref(true);
const tags = ref([]);

onMounted(async () => {
  try {
    tags.value = await useTags();
  } catch (error) {
    console.error('Error loading tags:', error);
  } finally {
    loading.value = false;
  }
});
</script>
