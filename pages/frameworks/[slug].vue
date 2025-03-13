<template>
  <div class="container mx-auto px-4 py-8">
    <div v-if="loading" class="flex justify-center py-8">
      <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary-600"></div>
    </div>
    
    <div v-else-if="!framework" class="text-center py-8">
      <h2 class="text-2xl font-bold text-gray-800 mb-2">Framework not found</h2>
      <p class="text-gray-600 mb-6">The framework you're looking for doesn't exist or has been removed.</p>
      <NuxtLink to="/frameworks" class="text-primary-600 hover:text-primary-700 font-medium">
        Back to Frameworks
      </NuxtLink>
    </div>
    
    <div v-else>
      <div class="mb-8">
        <div class="flex items-center gap-2 text-sm text-gray-500 mb-4">
          <NuxtLink to="/" class="hover:text-primary-600">Home</NuxtLink>
          <span>/</span>
          <NuxtLink to="/frameworks" class="hover:text-primary-600">Frameworks</NuxtLink>
          <span>/</span>
          <span class="text-gray-900">{{ framework.name }}</span>
        </div>
        
        <div class="bg-white rounded-lg shadow-md p-6 mb-8">
          <div class="flex flex-col md:flex-row md:items-center justify-between mb-6">
            <h1 class="text-3xl font-bold text-gray-900 mb-2 md:mb-0">{{ framework.name }}</h1>
            <div class="flex items-center gap-2">
              <span class="bg-primary-100 text-primary-800 text-sm font-medium px-3 py-1 rounded-full">
                {{ framework.version }}
              </span>
              <a 
                v-if="framework.website_url" 
                :href="framework.website_url" 
                target="_blank" 
                rel="noopener noreferrer"
                class="inline-flex items-center text-gray-500 hover:text-primary-600 bg-gray-100 hover:bg-gray-200 px-3 py-1 rounded-md text-sm"
              >
                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9H3m9 9a9 9 0 01-9-9m9 9c1.657 0 3-4.03 3-9s-1.343-9-3-9m0 18c-1.657 0-3-4.03-3-9s1.343-9 3-9m-9 9a9 9 0 019-9" />
                </svg>
                Website
              </a>
              <a 
                v-if="framework.github_url" 
                :href="framework.github_url" 
                target="_blank" 
                rel="noopener noreferrer"
                class="inline-flex items-center text-gray-500 hover:text-primary-600 bg-gray-100 hover:bg-gray-200 px-3 py-1 rounded-md text-sm"
              >
                <svg class="h-4 w-4 mr-1" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                  <path fill-rule="evenodd" d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z" clip-rule="evenodd" />
                </svg>
                GitHub
              </a>
            </div>
          </div>
          
          <p class="text-gray-700 mb-6">{{ framework.description }}</p>
          
          <div class="flex flex-wrap gap-2 mb-6">
            <NuxtLink 
              v-for="tag in framework.tags" 
              :key="tag.id"
              :to="`/tags/${tag.slug}`"
              class="bg-gray-100 hover:bg-gray-200 text-gray-800 text-sm font-medium px-3 py-1 rounded-md"
            >
              {{ tag.name }}
            </NuxtLink>
          </div>
        </div>
        
        <h2 class="text-2xl font-bold mb-6">Libraries for {{ framework.name }}</h2>
        
        <div v-if="loadingLibraries" class="flex justify-center py-8">
          <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary-600"></div>
        </div>
        
        <div v-else-if="libraries.length === 0" class="text-center py-8 bg-white rounded-lg shadow-md">
          <p class="text-gray-500">No libraries found for this framework</p>
        </div>
        
        <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <LibraryCard v-for="library in libraries" :key="library.id" :library="library" />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';

const route = useRoute();
const slug = route.params.slug;

const loading = ref(true);
const loadingLibraries = ref(true);
const framework = ref(null);
const libraries = ref([]);

onMounted(async () => {
  try {
    framework.value = await useFramework(slug);
    loading.value = false;
    
    if (framework.value) {
      libraries.value = await useLibraries(framework.value.id);
    }
  } catch (error) {
    console.error(`Error loading framework ${slug}:`, error);
  } finally {
    loadingLibraries.value = false;
  }
});
</script>
