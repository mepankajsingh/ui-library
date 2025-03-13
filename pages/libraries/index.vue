<template>
  <div class="container mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold mb-6">UI Libraries</h1>
    
    <div class="mb-8">
      <div class="flex flex-wrap gap-4 mb-4">
        <button 
          @click="selectedFramework = null" 
          :class="[
            'px-4 py-2 text-sm rounded-md',
            !selectedFramework ? 'bg-primary-600 text-white' : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
          ]"
        >
          All
        </button>
        <button 
          v-for="framework in frameworks" 
          :key="framework.id"
          @click="selectedFramework = framework.id"
          :class="[
            'px-4 py-2 text-sm rounded-md',
            selectedFramework === framework.id ? 'bg-primary-600 text-white' : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
          ]"
        >
          {{ framework.name }}
        </button>
      </div>
    </div>
    
    <div v-if="loading" class="flex justify-center py-8">
      <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary-600"></div>
    </div>
    
    <div v-else-if="filteredLibraries.length === 0" class="text-center py-8 text-gray-500">
      No libraries found
    </div>
    
    <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      <LibraryCard v-for="library in filteredLibraries" :key="library.id" :library="library" />
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';

const loading = ref(true);
const libraries = ref([]);
const frameworks = ref([]);
const selectedFramework = ref(null);

const filteredLibraries = computed(() => {
  if (!selectedFramework.value) return libraries.value;
  return libraries.value.filter(lib => lib.framework.id === selectedFramework.value);
});

onMounted(async () => {
  try {
    const [librariesData, frameworksData] = await Promise.all([
      useLibraries(),
      useFrameworks()
    ]);
    
    libraries.value = librariesData;
    frameworks.value = frameworksData;
  } catch (error) {
    console.error('Error loading libraries:', error);
  } finally {
    loading.value = false;
  }
});
</script>
