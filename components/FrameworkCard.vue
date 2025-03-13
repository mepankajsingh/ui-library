<template>
  <NuxtLink :to="`/frameworks/${framework.slug}`" class="block">
    <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow">
      <div class="p-6">
        <div class="flex items-center justify-between mb-4">
          <h3 class="text-xl font-semibold text-gray-900">{{ framework.name }}</h3>
          <span class="bg-primary-100 text-primary-800 text-xs font-medium px-2.5 py-0.5 rounded-full">{{ framework.version }}</span>
        </div>
        <p class="text-gray-600 text-sm mb-4 line-clamp-2">{{ framework.description }}</p>
        <div class="flex flex-wrap gap-2 mb-4">
          <span 
            v-for="tag in framework.tags" 
            :key="tag.id" 
            class="bg-gray-100 text-gray-800 text-xs font-medium px-2.5 py-0.5 rounded"
          >
            {{ tag.name }}
          </span>
        </div>
        <div class="flex items-center justify-between text-sm">
          <div class="flex items-center text-gray-500">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
            </svg>
            <span>{{ framework.libraries_count || 0 }} libraries</span>
          </div>
          <div class="flex items-center text-primary-600">
            <span>View details</span>
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
            </svg>
          </div>
        </div>
      </div>
    </div>
  </NuxtLink>
</template>

<script setup>
defineProps({
  framework: {
    type: Object,
    required: true
  }
});
</script>
