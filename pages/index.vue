<template>
  <div>
    <section class="py-12 md:py-20 bg-gradient-to-r from-primary-600 to-primary-800 text-white">
      <div class="container mx-auto px-4 text-center">
        <h1 class="text-4xl md:text-5xl font-bold mb-4">Find the Perfect UI Library</h1>
        <p class="text-xl md:text-2xl mb-8 max-w-3xl mx-auto">Discover and compare UI libraries for your JavaScript framework projects</p>
        
        <div class="max-w-md mx-auto">
          <div class="relative">
            <input
              type="text"
              v-model="searchQuery"
              placeholder="Search for libraries or frameworks..."
              class="w-full pl-10 pr-4 py-3 text-gray-900 bg-white border-0 rounded-lg shadow-md focus:outline-none focus:ring-2 focus:ring-primary-500"
              @keyup.enter="search"
            />
            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
              </svg>
            </div>
            <button 
              @click="search"
              class="absolute inset-y-0 right-0 px-4 text-white bg-primary-600 rounded-r-lg hover:bg-primary-700 focus:outline-none"
            >
              Search
            </button>
          </div>
        </div>
      </div>
    </section>
    
    <section class="py-12">
      <div class="container mx-auto px-4">
        <h2 class="text-2xl font-bold mb-6">Popular Frameworks</h2>
        <div v-if="pending" class="flex justify-center py-8">
          <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary-600"></div>
        </div>
        <div v-else-if="frameworks.length === 0" class="text-center py-8 text-gray-500">
          No frameworks found
        </div>
        <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <FrameworkCard v-for="framework in frameworks.slice(0, 6)" :key="framework.id" :framework="framework" />
        </div>
        <div class="mt-6 text-center">
          <NuxtLink to="/frameworks" class="inline-flex items-center text-primary-600 hover:text-primary-700">
            View all frameworks
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 ml-1" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
            </svg>
          </NuxtLink>
        </div>
      </div>
    </section>
    
    <section class="py-12 bg-gray-50">
      <div class="container mx-auto px-4">
        <h2 class="text-2xl font-bold mb-6">Featured Libraries</h2>
        <div v-if="pending" class="flex justify-center py-8">
          <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary-600"></div>
        </div>
        <div v-else-if="libraries.length === 0" class="text-center py-8 text-gray-500">
          No libraries found
        </div>
        <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <LibraryCard v-for="library in libraries.slice(0, 6)" :key="library.id" :library="library" />
        </div>
        <div class="mt-6 text-center">
          <NuxtLink to="/libraries" class="inline-flex items-center text-primary-600 hover:text-primary-700">
            View all libraries
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 ml-1" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
            </svg>
          </NuxtLink>
        </div>
      </div>
    </section>
    
    <section class="py-12">
      <div class="container mx-auto px-4">
        <h2 class="text-2xl font-bold mb-6">Browse by Tags</h2>
        <div v-if="pending" class="flex justify-center py-8">
          <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary-600"></div>
        </div>
        <div v-else-if="tags.length === 0" class="text-center py-8 text-gray-500">
          No tags found
        </div>
        <div v-else class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
          <TagCard v-for="tag in tags.slice(0, 8)" :key="tag.id" :tag="tag" />
        </div>
        <div class="mt-6 text-center">
          <NuxtLink to="/tags" class="inline-flex items-center text-primary-600 hover:text-primary-700">
            View all tags
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 ml-1" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
            </svg>
          </NuxtLink>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();
const searchQuery = ref('');

// Use useFetch for SSR data fetching
const { data: frameworksData, pending: frameworksPending } = await useFetch('/api/frameworks');
const { data: librariesData, pending: librariesPending } = await useFetch('/api/libraries');
const { data: tagsData, pending: tagsPending } = await useFetch('/api/tags');

// Computed properties for the data
const frameworks = computed(() => frameworksData.value || []);
const libraries = computed(() => librariesData.value || []);
const tags = computed(() => tagsData.value || []);

// Compute overall pending state
const pending = computed(() => frameworksPending.value || librariesPending.value || tagsPending.value);

const search = () => {
  if (searchQuery.value.trim()) {
    router.push({
      path: '/search',
      query: { q: searchQuery.value }
    });
  }
};
</script>
