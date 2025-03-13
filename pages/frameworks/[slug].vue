<template>
  <div class="container mx-auto px-4 py-8">
    <div v-if="pending" class="flex justify-center py-8">
      <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary-600"></div>
    </div>
    
    <div v-else-if="!framework" class="text-center py-8">
      <h1 class="text-2xl font-bold text-gray-700 mb-4">Framework not found</h1>
      <p class="text-gray-500 mb-6">The framework you're looking for doesn't exist or has been removed.</p>
      <NuxtLink to="/frameworks" class="text-primary-600 hover:text-primary-700">
        Back to frameworks
      </NuxtLink>
    </div>
    
    <div v-else>
      <div class="flex flex-col md:flex-row items-start gap-6 mb-8">
        <div class="w-24 h-24 flex-shrink-0 bg-white rounded-lg shadow-md p-2 flex items-center justify-center">
          <img v-if="framework.logo_url" :src="framework.logo_url" :alt="framework.name" class="max-w-full max-h-full object-contain" />
          <div v-else class="w-full h-full flex items-center justify-center bg-gray-100 text-gray-400 text-xl font-bold">
            {{ framework.name.charAt(0) }}
          </div>
        </div>
        
        <div class="flex-grow">
          <h1 class="text-3xl font-bold mb-2">{{ framework.name }}</h1>
          <p class="text-gray-600 mb-4">{{ framework.description }}</p>
          
          <div class="flex flex-wrap gap-2 mb-4">
            <span v-for="tag in framework.tags" :key="tag.tag_id.id" class="px-3 py-1 bg-gray-100 text-gray-700 text-sm rounded-full">
              {{ tag.tag_id.name }}
            </span>
          </div>
          
          <div class="flex flex-wrap gap-4">
            <a v-if="framework.website_url" :href="framework.website_url" target="_blank" rel="noopener noreferrer" class="inline-flex items-center text-primary-600 hover:text-primary-700">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9H3m9 9a9 9 0 01-9-9m9 9c1.657 0 3-4.03 3-9s-1.343-9-3-9m0 18c-1.657 0-3-4.03-3-9s1.343-9 3-9m-9 9a9 9 0 019-9" />
              </svg>
              Website
            </a>
            <a v-if="framework.github_url" :href="framework.github_url" target="_blank" rel="noopener noreferrer" class="inline-flex items-center text-primary-600 hover:text-primary-700">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" fill="currentColor" viewBox="0 0 24 24">
                <path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/>
              </svg>
              GitHub
            </a>
            <a v-if="framework.npm_url" :href="framework.npm_url" target="_blank" rel="noopener noreferrer" class="inline-flex items-center text-primary-600 hover:text-primary-700">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" fill="currentColor" viewBox="0 0 24 24">
                <path d="M0 0v24h24v-24h-24zm13 21h-2v-9h-3v9h-5v-18h18v18h-8z"/>
              </svg>
              NPM
            </a>
          </div>
        </div>
      </div>
      
      <div v-if="libraries.length > 0" class="mt-12">
        <h2 class="text-2xl font-bold mb-6">UI Libraries for {{ framework.name }}</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <LibraryCard v-for="library in libraries" :key="library.id" :library="library" />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
const route = useRoute();
const slug = route.params.slug;

// Fetch framework data
const { data: framework, pending: frameworkPending } = await useFetch(`/api/framework/${slug}`);

// Fetch libraries for this framework
const { data: librariesData, pending: librariesPending } = await useFetch(`/api/libraries`, {
  query: { frameworkId: framework.value?.id }
});

// Computed property for libraries
const libraries = computed(() => librariesData.value || []);

// Overall pending state
const pending = computed(() => frameworkPending.value || librariesPending.value);

// Set page title
useHead({
  title: framework.value ? `${framework.value.name} - UI Library Directory` : 'Framework - UI Library Directory'
});
</script>
