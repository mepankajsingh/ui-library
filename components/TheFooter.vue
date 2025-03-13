<template>
  <footer class="bg-gray-800 text-white py-8">
    <div class="container mx-auto px-4">
      <div class="flex flex-col md:flex-row justify-between">
        <div class="mb-6 md:mb-0">
          <h3 class="text-lg font-semibold mb-2">UI Library Directory</h3>
          <p class="text-gray-400 text-sm">Find the perfect UI library for your JavaScript framework project</p>
        </div>
        
        <div class="grid grid-cols-2 gap-8">
          <div>
            <h4 class="text-sm font-semibold mb-3 text-gray-300">Navigation</h4>
            <ul class="space-y-2">
              <li><NuxtLink to="/" class="text-gray-400 hover:text-white text-sm">Home</NuxtLink></li>
              <li><NuxtLink to="/frameworks" class="text-gray-400 hover:text-white text-sm">Frameworks</NuxtLink></li>
              <li><NuxtLink to="/libraries" class="text-gray-400 hover:text-white text-sm">Libraries</NuxtLink></li>
              <li><NuxtLink to="/tags" class="text-gray-400 hover:text-white text-sm">Tags</NuxtLink></li>
            </ul>
          </div>
          
          <div>
            <h4 class="text-sm font-semibold mb-3 text-gray-300">Resources</h4>
            <ul class="space-y-2">
              <li><a href="https://nuxt.com" target="_blank" rel="noopener noreferrer" class="text-gray-400 hover:text-white text-sm">Nuxt.js</a></li>
              <li><a href="https://tailwindcss.com" target="_blank" rel="noopener noreferrer" class="text-gray-400 hover:text-white text-sm">Tailwind CSS</a></li>
              <li><a href="https://supabase.com" target="_blank" rel="noopener noreferrer" class="text-gray-400 hover:text-white text-sm">Supabase</a></li>
            </ul>
          </div>
        </div>
      </div>
      
      <div class="mt-8 pt-6 border-t border-gray-700 text-center text-gray-400 text-sm">
        <p>&copy; {{ new Date().getFullYear() }} UI Library Directory. All rights reserved.</p>
      </div>
    </div>
  </footer>
</template>
