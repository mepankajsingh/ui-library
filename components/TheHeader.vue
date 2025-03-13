<template>
  <header class="bg-white shadow-sm">
    <div class="container mx-auto px-4 py-4 flex items-center justify-between">
      <NuxtLink to="/" class="flex items-center space-x-2">
        <span class="text-primary-600 text-2xl font-bold">UILibs</span>
      </NuxtLink>
      
      <nav class="hidden md:flex items-center space-x-6">
        <NuxtLink to="/frameworks" class="text-gray-600 hover:text-primary-600 transition-colors">
          Frameworks
        </NuxtLink>
        <NuxtLink to="/libraries" class="text-gray-600 hover:text-primary-600 transition-colors">
          Libraries
        </NuxtLink>
        <NuxtLink to="/tags" class="text-gray-600 hover:text-primary-600 transition-colors">
          Tags
        </NuxtLink>
      </nav>
      
      <div class="flex items-center space-x-4">
        <SearchBar />
        <button class="md:hidden" @click="toggleMobileMenu">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-gray-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
          </svg>
        </button>
      </div>
    </div>
    
    <!-- Mobile menu -->
    <div v-if="mobileMenuOpen" class="md:hidden bg-white border-t border-gray-100 py-2">
      <div class="container mx-auto px-4 space-y-2">
        <NuxtLink to="/frameworks" class="block py-2 text-gray-600 hover:text-primary-600">
          Frameworks
        </NuxtLink>
        <NuxtLink to="/libraries" class="block py-2 text-gray-600 hover:text-primary-600">
          Libraries
        </NuxtLink>
        <NuxtLink to="/tags" class="block py-2 text-gray-600 hover:text-primary-600">
          Tags
        </NuxtLink>
      </div>
    </div>
  </header>
</template>

<script setup>
import { ref } from 'vue';

const mobileMenuOpen = ref(false);

const toggleMobileMenu = () => {
  mobileMenuOpen.value = !mobileMenuOpen.value;
};
</script>
