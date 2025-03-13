<template>
  <div class="container mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold mb-2">Search Results</h1>
    <p class="text-gray-600 mb-8">Results for "{{ query }}"</p>
    
    <div v-if="pending" class="flex justify-center py-8">
      <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary-600"></div>
    </div>
    
    <div v-else-if="!results || (results.frameworks.length === 0 && results.libraries.length === 0)" class="text-center py-8">
      <p class="text-gray-500 mb-6">No results found for "{{ query }}"</p>
      <NuxtLink to="/" class="text-primary-600 hover:text-primary-700">
        Back to home
      </NuxtLink>
    </div>
    
    <div v-else>
      <div v-if="results.frameworks.length > 0" class="mb-12">
        <h2 class="text-2xl font-bold mb-6">Frameworks</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <FrameworkCard v-for="framework in results.frameworks" :key="framework.id" :framework="framework" />
        </div>
      </div>
      
      <div v-if="results.libraries.length > 0">
        <h2 class="text-2xl font-bold mb-6">Libraries</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <LibraryCard v-for="library in results.libraries" :key="library.id" :library="library" />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
const route = useRoute();
const query = computed(() => route.query.q || '');

// Use useFetch for SSR data fetching
const { data: results, pending } = await useFetch('/api/search', {
  query: { q: query }
});

// Set page title
useHead({
  title: `Search: ${query.value} - UI Library Directory`
});
</script>
