<template>
  <div class="container mx-auto px-4 py-8">
    <div v-if="pending" class="flex justify-center py-8">
      <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary-600"></div>
    </div>
    
    <div v-else-if="!tag" class="text-center py-8">
      <h1 class="text-2xl font-bold text-gray-700 mb-4">Tag not found</h1>
      <p class="text-gray-500 mb-6">The tag you're looking for doesn't exist or has been removed.</p>
      <NuxtLink to="/tags" class="text-primary-600 hover:text-primary-700">
        Back to tags
      </NuxtLink>
    </div>
    
    <div v-else>
      <h1 class="text-3xl font-bold mb-2">{{ tag.name }}</h1>
      <p v-if="tag.description" class="text-gray-600 mb-8">{{ tag.description }}</p>
      
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
      
      <div v-if="frameworks.length === 0 && libraries.length === 0" class="text-center py-8 text-gray-500">
        No frameworks or libraries found with this tag
      </div>
    </div>
  </div>
</template>

<script setup>
const route = useRoute();
const slug = route.params.slug;

// Fetch tag data
const { data: tag, pending: tagPending } = await useFetch(`/api/tag/${slug}`);

// Fetch frameworks with this tag
const { data: frameworksData, pending: frameworksPending } = await useFetch(`/api/tag/${slug}/frameworks`);

// Fetch libraries with this tag
const { data: librariesData, pending: librariesPending } = await useFetch(`/api/tag/${slug}/libraries`);

// Computed properties
const frameworks = computed(() => frameworksData.value || []);
const libraries = computed(() => librariesData.value || []);

// Overall pending state
const pending = computed(() => tagPending.value || frameworksPending.value || librariesPending.value);

// Set page title
useHead({
  title: tag.value ? `${tag.value.name} - UI Library Directory` : 'Tag - UI Library Directory'
});
</script>
