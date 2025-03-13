<template>
  <NuxtLink :to="`/frameworks/${framework.slug}`" class="block bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow">
    <div class="p-6">
      <div class="flex items-center mb-4">
        <div class="w-12 h-12 flex-shrink-0 bg-white rounded-md shadow-sm p-1 flex items-center justify-center">
          <img v-if="framework.logo_url" :src="framework.logo_url" :alt="framework.name" class="max-w-full max-h-full object-contain" />
          <div v-else class="w-full h-full flex items-center justify-center bg-gray-100 text-gray-400 text-xl font-bold">
            {{ framework.name.charAt(0) }}
          </div>
        </div>
        <div class="ml-3">
          <h3 class="text-lg font-semibold text-gray-900">{{ framework.name }}</h3>
          <div class="flex items-center text-sm text-gray-500">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z" />
            </svg>
            {{ framework.stars.toLocaleString() }}
          </div>
        </div>
      </div>
      
      <p class="text-gray-600 text-sm mb-4 line-clamp-2">{{ framework.description }}</p>
      
      <div class="flex flex-wrap gap-2">
        <span v-for="tag in tags" :key="tag.id" class="px-2 py-1 bg-gray-100 text-gray-700 text-xs rounded-full">
          {{ tag.name }}
        </span>
      </div>
    </div>
  </NuxtLink>
</template>

<script setup>
const props = defineProps({
  framework: {
    type: Object,
    required: true
  }
});

// Extract tags from the framework object
const tags = computed(() => {
  if (!props.framework.tags) return [];
  
  // Handle the new structure from the API
  return props.framework.tags.map(tag => tag.tag_id).slice(0, 3);
});
</script>
