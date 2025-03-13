<template>
  <NuxtLink :to="`/libraries/${library.slug}`" class="block bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow">
    <div class="p-6">
      <div class="flex items-center mb-4">
        <div class="w-12 h-12 flex-shrink-0 bg-white rounded-md shadow-sm p-1 flex items-center justify-center">
          <img v-if="library.logo_url" :src="library.logo_url" :alt="library.name" class="max-w-full max-h-full object-contain" />
          <div v-else class="w-full h-full flex items-center justify-center bg-gray-100 text-gray-400 text-xl font-bold">
            {{ library.name.charAt(0) }}
          </div>
        </div>
        <div class="ml-3">
          <h3 class="text-lg font-semibold text-gray-900">{{ library.name }}</h3>
          <p v-if="library.framework" class="text-sm text-gray-500">
            {{ library.framework.name }}
          </p>
        </div>
      </div>
      
      <p class="text-gray-600 text-sm mb-4 line-clamp-2">{{ library.description }}</p>
      
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
  library: {
    type: Object,
    required: true
  }
});

// Extract tags from the library object
const tags = computed(() => {
  if (!props.library.tags) return [];
  
  // Handle the new structure from the API
  return props.library.tags.map(tag => tag.tag_id).slice(0, 3);
});
</script>
