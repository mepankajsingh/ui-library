<template>
  <div class="container mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold mb-2">Search Results</h1>
    <p class="text-gray-600 mb-8" v-if="query">Showing results for "{{ query }}"</p>
    
    <div v-if="loading" class="flex justify-center py-8">
      <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary-600"></div>
    </div>
    
    <div v-else-if="!query" class="text-center py-8 bg-white rounded-lg shadow-md">
      <p class="text-gray-500">Please enter a search query</p>
    </div>
    
    <div v-else-if="frameworks.length === 0 && libraries.length === 0" class="text-center py-8 bg-white rounded-lg shadow-md">
      <p class="text-gray-500">No results found for "{{ query }}"</p>
    </div>
    
    <div v-else>
      <div v-if="frameworks.length > 0" class="mb-12">
        <h2 class="text-2xl font-bold mb-6">Frameworks ({{ frameworks.length }})</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <FrameworkCard v-for="framework in frameworks" :key="framework.id" :framework="framework" />
        </div>
      </div>
      
      <div v-if="libraries.length > 0">
        <h2 class="text-2xl font-bold mb-6">Libraries ({{ libraries.length }})</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <LibraryCard v-for="library in libraries" :key="library.id" :library="library" />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue';
import { useRoute } from 'vue-router';

const route = useRoute();
const query = ref(route.query.q || '');
const loading = ref(false);
const frameworks = ref([]);
const libraries = ref([]);

const performSearch = async () => {
  if (!query.value) {
    frameworks.value = [];
    libraries.value = [];
    return;
  }
  
  loading.value = true;
  
  try {
    const results = await useSearch(query.value);
    frameworks.value = results.frameworks;
    libraries.value = results.libraries;
  } catch (error) {
    console.error('Error performing search:', error);
  } finally {
    loading.value = false;
  }
};

onMounted(performSearch);

watch(() => route.query.q, (newQuery) => {
  query.value = newQuery || '';
  performSearch();
});
</script>
