<template>
  <div class="draft-history container-fluid">
    <h2 class="text-center my-4">Draft History</h2>
    <div class="form-group row justify-content-center mb-4">
      <label for="yearSelect" class="col-form-label col-auto">Select Draft Year:</label>
      <div class="col-auto">
        <select id="yearSelect" class="form-select" v-model="selectedYear" @change="fetchDraftHistory">
          <option v-for="year in years" :key="year" :value="year">{{ year }}</option>
        </select>
      </div>
    </div>
    <div v-if="draftHistory.length > 0" class="list-group">
      <div
        v-for="(record, index) in draftHistory"
        :key="record.id"
        :class="['list-group-item', 'list-group-item-dark', 'd-flex', 'justify-content-between', 'align-items-center', highlightClass(index)]"
      >
        <div>
          <h5 class="mb-1">{{ record.player_name }}</h5>
          <p class="mb-1">{{ record.team_name }}</p>
          <small>
            <strong>Draft Year:</strong> {{ record.draft_year }} | 
            <strong>Round:</strong> {{ record.round }} | 
            <strong>Pick:</strong> {{ record.round_pick }} | 
            <strong>Overall:</strong> {{ record.overall_pick }}
          </small>
        </div>
        <span class="badge" :class="badgeClass(index)">
          {{ index + 1 }}
        </span>
      </div>
    </div>
    <div v-else class="text-center mt-4">
      <p>No data available for the selected year.</p>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'DraftTab',
  data() {
    return {
      selectedYear: new Date().getFullYear(),
      draftHistory: [],
      years: Array.from({ length: 75 }, (_, i) => new Date().getFullYear() - i)
    };
  },
  async created() {
    await this.fetchDraftHistory();
  },
  methods: {
    async fetchDraftHistory() {
      try {
        const response = await axios.get(`http://api.mynbaassistant.com/api/draft/${this.selectedYear}`, {
          headers: {
            Authorization: `Bearer ${localStorage.getItem('token')}`
          }
        });
        this.draftHistory = response.data;
      } catch (error) {
        console.error(`Error fetching draft history for year ${this.selectedYear}:`, error);
        this.draftHistory = [];
      }
    },
    highlightClass(index) {
      if (index === 0) {
        return 'highlight-1';
      } else if (index < 3) {
        return 'highlight-2';
      } else if (index < 10) {
        return 'highlight-3';
      } else if (index < 20) {
        return 'highlight-4';
      }
      return '';
    },
    badgeClass(index) {
      if (index === 0) {
        return 'bg-gold';
      } else if (index < 3) {
        return 'bg-silver';
      } else if (index < 10) {
        return 'bg-bronze';
      } else if (index < 20) {
        return 'bg-blue';
      }
      return 'bg-secondary';
    }
  }
};
</script>

<style scoped>
.draft-history {
  background-color: #121212; /* Darker background */
  color: #e0e0e0; /* Lighter text color */
  min-height: 100vh;
}

.form-select {
  background-color: #2a2a2a;
  color: #e0e0e0;
  border: 1px solid #555;
}

.list-group-item {
  background-color: #2a2a2a; /* Darker item background */
  border: none;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  color: #e0e0e0; /* Lighter text color */
}

.list-group-item:hover {
  transform: translateY(-3px);
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.5);
}

.highlight-1 {
  border-left: 5px solid #ffd700; /* Gold */
  background: linear-gradient(90deg, rgba(255, 215, 0, 0.3), rgba(42, 42, 42, 0));
}

.highlight-2 {
  border-left: 5px solid #c0c0c0; /* Silver */
  background: linear-gradient(90deg, rgba(192, 192, 192, 0.3), rgba(42, 42, 42, 0));
}

.highlight-3 {
  border-left: 5px solid #cd7f32; /* Bronze */
  background: linear-gradient(90deg, rgba(205, 127, 50, 0.3), rgba(42, 42, 42, 0));
}

.highlight-4 {
  border-left: 5px solid #007bff; /* Blue */
  background: linear-gradient(90deg, rgba(0, 123, 255, 0.3), rgba(42, 42, 42, 0));
}

.bg-gold {
  background-color: #ffd700 !important;
  color: #000 !important;
}

.bg-silver {
  background-color: #c0c0c0 !important;
  color: #000 !important;
}

.bg-bronze {
  background-color: #cd7f32 !important;
  color: #000 !important;
}

.bg-blue {
  background-color: #007bff !important;
  color: #000 !important;
}
</style>
