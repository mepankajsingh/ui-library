<template>
  <NuxtLink :to="`/tags/${tag.slug}`" class="block">
    <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow">
      <div class="p-4">
        <h3 class="text-lg font-medium text-gray-900">{{ tag.name }}</h3>
        <div class="flex items-center justify-between mt-2 text-sm">
          <div class="flex items-center text-gray-500">
            <span>{{ tag.count || 0 }} items</span>
          </div>
          <div class="flex items-center text-primary-600">
            <span>View</span>
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
  tag: {
    type: Object,
    required: true
  }
});
</script>
