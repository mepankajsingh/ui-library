<template>
  <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow">
    <div class="p-6">
      <div class="flex items-center justify-between mb-4">
        <h3 class="text-xl font-semibold text-gray-900">{{ library.name }}</h3>
        <span class="bg-primary-100 text-primary-800 text-xs font-medium px-2.5 py-0.5 rounded-full">{{ library.version }}</span>
      </div>
      <p class="text-gray-600 text-sm mb-4 line-clamp-2">{{ library.description }}</p>
      
      <div class="mb-4">
        <NuxtLink :to="`/frameworks/${library.framework.slug}`" class="inline-flex items-center text-sm text-gray-600 hover:text-primary-600">
          <span class="font-medium">{{ library.framework.name }}</span>
        </NuxtLink>
      </div>
      
      <div class="flex flex-wrap gap-2 mb-4">
        <span 
          v-for="tag in library.tags" 
          :key="tag.id" 
          class="bg-gray-100 text-gray-800 text-xs font-medium px-2.5 py-0.5 rounded"
        >
          {{ tag.name }}
        </span>
      </div>
      
      <div class="flex items-center justify-between text-sm">
        <div class="flex items-center text-gray-500">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
          </svg>
          <span>Updated {{ formatDate(library.updated_at) }}</span>
        </div>
        <a :href="library.github_url" target="_blank" rel="noopener noreferrer" class="flex items-center text-primary-600">
          <span>GitHub</span>
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1" viewBox="0 0 20 20" fill="currentColor">
            <path d="M11 3a1 1 0 100 2h2.586l-6.293 6.293a1 1 0 101.414 1.414L15 6.414V9a1 1 0 102 0V4a1 1 0 00-1-1h-5z" />
            <path d="M5 5a2 2 0 00-2 2v8a2 2 0 002 2h8a2 2 0 002-2v-3a1 1 0 10-2 0v3H5V7h3a1 1 0 000-2H5z" />
          </svg>
        </a>
      </div>
    </div>
  </div>
</template>

<script setup>
defineProps({
  library: {
    type: Object,
    required: true
  }
});

const formatDate = (dateString) => {
  if (!dateString) return 'N/A';
  const date = new Date(dateString);
  return new Intl.DateTimeFormat('en-US', { 
    year: 'numeric', 
    month: 'short', 
    day: 'numeric' 
  }).format(date);
};
</script>
