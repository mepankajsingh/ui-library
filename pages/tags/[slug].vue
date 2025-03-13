<template>
  <div class="container mx-auto px-4 py-8">
    <div v-if="loading" class="flex justify-center py-8">
      <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary-600"></div>
    </div>
    
    <div v-else-if="!tag" class="text-center py-8">
      <h2 class="text-2xl font-bold text-gray-800 mb-2">Tag not found</h2>
      <p class="text-gray-600 mb-6">The tag you're looking for doesn't exist or has been removed.</p>
      <NuxtLink to="/tags" class="text-primary-600 hover:text-primary-700 font-medium">
        Back to Tags
      </NuxtLink>
    </div>
    
    <div v-else>
      <div class="mb-8">
        <div class="flex items-center gap-2 text-sm text-gray-500 mb-4">
          <NuxtLink to="/" class="hover:text-primary-600">Home</NuxtLink>
          <span>/</span>
          <NuxtLink to="/tags" class="hover:text-primary-600">Tags</NuxtLink>
          <span>/</span>
          <span class="text-gray-900">{{ tag.name }}</span>
        </div>
        
        <div class="bg-white rounded-lg shadow-md p-6 mb-8">
          <h1 class="text-3xl font-bold text-gray-900 mb-4">{{ tag.name }}</h1>
          <p v-if="tag.description" class="text-gray-700 mb-4">{{ tag.description }}</p>
        </div>
      </div>
      
      <div v-if="frameworks.length > 0" class="mb-12">
        <h2 class="text-2xl font-bold mb-6">Frameworks with this tag</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <FrameworkCard v-for="framework in frameworks" :key="framework.id" :framework="framework" />
        </div>
      </div>
      
      <div v-if="libraries.length > 0">
        <h2 class="text-2xl font-bold mb-6">Libraries with this tag</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <LibraryCard v-for="library in libraries" :key="library.id" :library="library" />
        </div>
      </div>
      
      <div v-if="frameworks.length === 0 && libraries.length === 0" class="text-center py-8 bg-white rounded-lg shadow-md">
        <p class="text-gray-500">No frameworks or libraries found with this tag</p>
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
const tag = ref(null);
const frameworks = ref([]);
const libraries = ref([]);

onMounted(async () => {
  try {
    tag.value = await useTag(slug);
    
    if (tag.value) {
      const [frameworksData, librariesData] = await Promise.all([
        useFrameworksByTag(tag.value.id),
        useLibrariesByTag(tag.value.id)
      ]);
      
      frameworks.value = frameworksData;
      libraries.value = librariesData;
    }
  } catch (error) {
    console.error(`Error loading tag ${slug}:`, error);
  } finally {
    loading.value = false;
  }
});
</script>
