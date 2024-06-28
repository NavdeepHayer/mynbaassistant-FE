<template>
  <div class="search-results p-3 h-100 d-flex flex-column">
    <div class="input-group mb-3">
      <input
        v-model="searchQuery"
        @input="searchPlayers"
        class="form-control"
        placeholder="Search for a player"
      />
      <div class="input-group-append">
        <button class="btn btn-outline-secondary" @click="searchPlayers">
          Search
        </button>
      </div>
    </div>

    <div class="pagination mb-3">
      <button @click="prevPage" :disabled="currentPage === 1" class="btn btn-secondary btn-sm">Previous</button>
      <span>Page {{ currentPage }} of {{ totalPages }}</span>
      <button @click="nextPage" :disabled="currentPage === totalPages" class="btn btn-secondary btn-sm">Next</button>
    </div>

    <div class="list-group flex-grow-1 overflow-auto">
      <a
        v-for="player in paginatedPlayers"
        :key="player.id"
        href="#"
        class="list-group-item list-group-item-action bg-dark text-white"
        @click="selectPlayer(player)"
      >
        {{ player.full_name }}
      </a>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'SearchResults',
  data() {
    return {
      searchQuery: '',
      players: [],
      filteredPlayers: [],
      currentPage: 1,
      itemsPerPage: 20,
    };
  },
  async created() {
    await this.fetchInitialPlayers();
  },
  methods: {
    async fetchInitialPlayers() {
      try {
        const response = await axios.get('http://api.mynbaassistant.com/api/players', {
          headers: {
            Authorization: `Bearer ${localStorage.getItem('token')}`,
          },
        });
        this.players = response.data;
        this.filteredPlayers = this.players;
        if (this.filteredPlayers.length > 0) {
          this.selectPlayer(this.filteredPlayers[0]);
        }
      } catch (error) {
        console.error('Error fetching NBA players:', error);
      }
    },
    searchPlayers() {
      if (this.searchQuery.trim() === '') {
        this.filteredPlayers = this.players;
      } else {
        this.filteredPlayers = this.players.filter(player =>
          player.full_name.toLowerCase().includes(this.searchQuery.toLowerCase())
        );
      }
      this.currentPage = 1;
    },
    nextPage() {
      if (this.currentPage < this.totalPages) {
        this.currentPage++;
      }
    },
    prevPage() {
      if (this.currentPage > 1) {
        this.currentPage--;
      }
    },
    selectPlayer(player) {
      this.$emit('select-player', player);
    }
  },
  computed: {
    totalPages() {
      return Math.ceil(this.filteredPlayers.length / this.itemsPerPage);
    },
    paginatedPlayers() {
      const start = (this.currentPage - 1) * this.itemsPerPage;
      const end = start + this.itemsPerPage;
      return this.filteredPlayers.slice(start, end);
    },
  },
};
</script>

<style scoped>
.search-results {
  display: flex;
  flex-direction: column;
  height: 100%;
}

.list-group-item {
  cursor: pointer;
}

.pagination {
  display: flex;
  justify-content: center;
  align-items: center;
}

.pagination button {
  margin: 0 5px;
}

.input-group .form-control {
  background-color: #2a2a2a;
  color: #fff;
  border: 1px solid #555;
}

.input-group .btn-outline-secondary {
  background-color: #444;
  color: #fff;
  border: 1px solid #555;
}

.input-group .btn-outline-secondary:hover {
  background-color: #555;
}
</style>
