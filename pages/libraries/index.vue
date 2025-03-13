<template>
  <div class="container mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold mb-6">UI Libraries</h1>
    
    <div v-if="pending" class="flex justify-center py-8">
      <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary-600"></div>
    </div>
    
    <div v-else-if="libraries.length === 0" class="text-center py-8 text-gray-500">
      No libraries found
    </div>
    
    <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      <LibraryCard v-for="library in libraries" :key="library.id" :library="library" />
    </div>
  </div>
</template>

<script setup>
// Use useFetch for SSR data fetching
const { data: librariesData, pending } = await useFetch('/api/libraries');

// Computed property for libraries
const libraries = computed(() => librariesData.value || []);

// Set page title
useHead({
  title: 'UI Libraries - UI Library Directory'
});
</script>
