<template>
  <header class="bg-white border-b border-gray-100">
    <div class="container mx-auto px-4">
      <div class="flex items-center justify-between h-14">
        <div class="flex items-center">
          <NuxtLink to="/" class="text-lg font-medium text-primary-600 hover:text-primary-700">UI Library Directory</NuxtLink>
        </div>
        
        <div class="flex items-center">
          <!-- Search button (visible on all screens) -->
          <NuxtLink to="/search" class="p-2 text-gray-500 hover:text-primary-600 mr-2" aria-label="Search">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
            </svg>
          </NuxtLink>
          
          <!-- Desktop Navigation -->
          <nav class="hidden md:flex space-x-4">
            <NuxtLink to="/frameworks" class="py-2 px-3 text-sm text-gray-600 hover:text-primary-600 rounded-md hover:bg-gray-50">Frameworks</NuxtLink>
            <NuxtLink to="/libraries" class="py-2 px-3 text-sm text-gray-600 hover:text-primary-600 rounded-md hover:bg-gray-50">Libraries</NuxtLink>
            <NuxtLink to="/tags" class="py-2 px-3 text-sm text-gray-600 hover:text-primary-600 rounded-md hover:bg-gray-50">Tags</NuxtLink>
          </nav>
          
          <!-- Mobile menu button -->
          <button 
            @click="isMenuOpen = !isMenuOpen" 
            class="md:hidden p-2 ml-2 text-gray-500 hover:text-primary-600 focus:outline-none"
            aria-label="Toggle menu"
          >
            <svg v-if="!isMenuOpen" xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
            </svg>
            <svg v-else xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>
      </div>
    </div>
    
    <!-- Mobile menu -->
    <div 
      v-show="isMenuOpen" 
      class="md:hidden border-t border-gray-100"
      v-click-outside="() => { isMenuOpen = false }"
    >
      <div class="py-2">
        <NuxtLink to="/frameworks" class="block px-4 py-2 text-sm text-gray-600 hover:bg-gray-50 hover:text-primary-600">Frameworks</NuxtLink>
        <NuxtLink to="/libraries" class="block px-4 py-2 text-sm text-gray-600 hover:bg-gray-50 hover:text-primary-600">Libraries</NuxtLink>
        <NuxtLink to="/tags" class="block px-4 py-2 text-sm text-gray-600 hover:bg-gray-50 hover:text-primary-600">Tags</NuxtLink>
      </div>
    </div>
  </header>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue';

const isMenuOpen = ref(false);

// Close mobile menu when clicking outside
const vClickOutside = {
  mounted(el, binding) {
    el._clickOutside = (event) => {
      if (!(el === event.target || el.contains(event.target))) {
        binding.value(event);
      }
    };
    document.addEventListener('click', el._clickOutside);
  },
  unmounted(el) {
    document.removeEventListener('click', el._clickOutside);
  }
};

// Close mobile menu when route changes
const route = useRoute();
watch(() => route.path, () => {
  isMenuOpen.value = false;
});

// Close mobile menu when pressing escape key
const handleEscape = (e) => {
  if (e.key === 'Escape' && isMenuOpen.value) {
    isMenuOpen.value = false;
  }
};

onMounted(() => {
  document.addEventListener('keydown', handleEscape);
});

onUnmounted(() => {
  document.removeEventListener('keydown', handleEscape);
});
</script>
