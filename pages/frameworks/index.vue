<template>
  <div class="container mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold mb-6">JavaScript Frameworks</h1>
    
    <div v-if="loading" class="flex justify-center py-8">
      <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary-600"></div>
    </div>
    
    <div v-else-if="frameworks.length === 0" class="text-center py-8 text-gray-500">
      No frameworks found
    </div>
    
    <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      <FrameworkCard v-for="framework in frameworks" :key="framework.id" :framework="framework" />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';

const loading = ref(true);
const frameworks = ref([]);

onMounted(async () => {
  try {
    frameworks.value = await useFrameworks();
  } catch (error) {
    console.error('Error loading frameworks:', error);
  } finally {
    loading.value = false;
  }
});
</script>
