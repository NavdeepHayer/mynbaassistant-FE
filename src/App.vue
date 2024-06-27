<template>
  <div class="app-container">
    <header class="header d-flex justify-content-between align-items-center px-4 py-2 shadow-sm" v-if="isAuthenticated">
      <button class="menu-button btn btn-dark" @click="toggleMenu">☰</button>
      <h1 class="mb-0">NBA Stats App</h1>
    </header>

    <div class="content d-flex">
      <aside :class="{ open: isMenuOpen }" class="sidebar" v-if="isAuthenticated">
        <nav>
          <ul class="nav flex-column">
            <li class="nav-item" @click="toggleMenu">
              <router-link to="/home" class="nav-link">Home</router-link>
            </li>
            <li class="nav-item" @click="toggleMenu">
              <router-link to="/search" class="nav-link">Search Player</router-link>
            </li>
            <li class="nav-item" @click="toggleMenu">
              <router-link to="/teams" class="nav-link">Teams</router-link>
            </li>
            <li class="nav-item" @click="toggleMenu">
              <router-link to="/about" class="nav-link">About</router-link>
            </li>
          </ul>
        </nav>
      </aside>
      
      <main class="p-4 flex-grow-1">
        <router-view @login="handleLogin"></router-view>
      </main>
    </div>

    <footer class="text-center py-2">
      <p>&copy; 2024 NBA Stats App</p>
    </footer>
  </div>
</template>

<script>
export default {
  data() {
    return {
      isMenuOpen: false,
      isAuthenticated: false,
    };
  },
  methods: {
    toggleMenu() {
      this.isMenuOpen = !this.isMenuOpen;
    },
    handleLogin() {
      this.isAuthenticated = true;
    },
  },
};
</script>

<style>
/* existing styles */
</style>
