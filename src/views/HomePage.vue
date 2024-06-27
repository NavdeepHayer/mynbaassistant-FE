<template>
  <div class="home-page container-fluid">
    <ul class="nav nav-tabs justify-content-center mt-4">
      <li class="nav-item">
        <a class="nav-link" :class="{ active: activeTab === 'teams' }" @click="activeTab = 'teams'" href="#">
          Teams
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" :class="{ active: activeTab === 'players' }" @click="activeTab = 'players'" href="#">
          Players
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" :class="{ active: activeTab === 'draft' }" @click="activeTab = 'draft'" href="#">
          Draft History
        </a>
      </li>
    </ul>

    <div v-if="activeTab === 'teams'" class="tab-content mt-4">
      <TeamsTab />
    </div>

    <div v-if="activeTab === 'players'" class="tab-content mt-4">
      <PlayersTab />
    </div>

    <div v-if="activeTab === 'draft'" class="tab-content mt-4">
      <DraftTab />
    </div>
  </div>
</template>

<script>
import TeamsTab from './TeamsTab.vue';
import PlayersTab from './PlayersTab.vue';
import DraftTab from './DraftTab.vue';

export default {
  name: 'HomePage',
  components: {
    TeamsTab,
    PlayersTab,
    DraftTab,
  },
  data() {
    return {
      activeTab: 'teams',
    };
  },
};
</script>

<style scoped>
.home-page {
  width: 100%;
  padding: 0 15px; /* Adjust padding as needed */
  background-color: #121212; /* Dark background for the entire page */
  color: #e0e0e0; /* Light text color */
}

.nav-tabs {
  margin-bottom: 20px;
  border-bottom: 1px solid #444; /* Border color to match dark theme */
}

.nav-item .nav-link {
  color: #e0e0e0; /* Light text color */
  background-color: #1a1a1a; /* Dark background for the nav links */
  border: 1px solid #444; /* Border color to match dark theme */
  margin-right: 5px; /* Add some space between the tabs */
  border-radius: 0; /* Ensure no rounded corners */
}

.nav-item .nav-link.active {
  background-color: #007bff; /* Active tab background */
  color: #fff; /* Active tab text color */
  border: 1px solid #007bff; /* Border to match active tab background */
}

.tab-content {
  padding: 15px; /* Add padding for better spacing */
  background-color: #1a1a1a; /* Match the dark theme */
  color: #e0e0e0; /* Light text color */
  border-radius: 8px; /* Rounded corners for modern look */
  border: 1px solid #444; /* Border color to match dark theme */
}

.container-fluid {
  background-color: #121212; /* Dark background for the entire page */
}

.table {
  background-color: #1a1a1a; /* Match table background to dark theme */
  color: #e0e0e0; /* Light text color */
  border: 1px solid #444; /* Border color to match dark theme */
}

.table th,
.table td {
  border: 1px solid #444; /* Border color to match dark theme */
}

.pagination-controls {
  display: flex;
  justify-content: space-between;
  margin-bottom: 15px;
  background-color: #1a1a1a; /* Match the dark theme */
  border: 1px solid #444; /* Border color to match dark theme */
  padding: 10px;
  border-radius: 8px;
}

.pagination-controls button {
  background-color: #007bff; /* Button background */
  color: #fff; /* Button text color */
  border: 1px solid #007bff; /* Button border */
}

.pagination-controls span {
  color: #e0e0e0; /* Light text color */
}
</style>
