<template>
  <div class="player-details">
    <h2>{{ player.full_name }}</h2>
    <div class="player-info">
      <p><strong>First Name:</strong> {{ player.first_name }}</p>
      <p><strong>Last Name:</strong> {{ player.last_name }}</p>
      <p><strong>Active:</strong> {{ player.is_active ? 'Yes' : 'No' }}</p>
    </div>
    <ul class="nav nav-tabs">
      <li class="nav-item">
        <a class="nav-link" :class="{ active: activeTab === 'gameLogs' }" @click="setActiveTab('gameLogs')" href="#">
          Game Logs
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" :class="{ active: activeTab === 'seasonStats' }" @click="setActiveTab('seasonStats')" href="#">
          Season Stats
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" :class="{ active: activeTab === 'playoffStats' }" @click="setActiveTab('playoffStats')" href="#">
          Playoff Stats
        </a>
      </li>
    </ul>
    <div v-if="activeTab === 'gameLogs'" class="tab-content mt-4">
      <div class="pagination-controls">
        <button @click="prevPage('gameLogs')" :disabled="gameLogsPage === 1" class="btn btn-secondary btn-sm">Previous</button>
        <span>Page {{ gameLogsPage }}</span>
        <button @click="nextPage('gameLogs')" :disabled="!hasMoreGameLogs" class="btn btn-secondary btn-sm">Next</button>
      </div>
      <div class="table-container">
        <table v-if="gameLogs.length">
          <thead>
            <tr>
              <th>Date</th>
              <th>Matchup</th>
              <th>WL</th>
              <th>MIN</th>
              <th>FGM</th>
              <th>FGA</th>
              <th>FG%</th>
              <th>3PM</th>
              <th>3PA</th>
              <th>3P%</th>
              <th>FTM</th>
              <th>FTA</th>
              <th>FT%</th>
              <th>OREB</th>
              <th>DREB</th>
              <th>REB</th>
              <th>AST</th>
              <th>STL</th>
              <th>BLK</th>
              <th>TOV</th>
              <th>PF</th>
              <th>PTS</th>
              <th>+/-</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="log in gameLogs" :key="log.game_id">
              <td>{{ log.game_date }}</td>
              <td>{{ log.matchup }}</td>
              <td>{{ log.wl }}</td>
              <td>{{ log.min }}</td>
              <td>{{ log.fgm }}</td>
              <td>{{ log.fga }}</td>
              <td>{{ log.fg_pct }}</td>
              <td>{{ log.fg3m }}</td>
              <td>{{ log.fg3a }}</td>
              <td>{{ log.fg3_pct }}</td>
              <td>{{ log.ftm }}</td>
              <td>{{ log.fta }}</td>
              <td>{{ log.ft_pct }}</td>
              <td>{{ log.oreb }}</td>
              <td>{{ log.dreb }}</td>
              <td>{{ log.reb }}</td>
              <td>{{ log.ast }}</td>
              <td>{{ log.stl }}</td>
              <td>{{ log.blk }}</td>
              <td>{{ log.tov }}</td>
              <td>{{ log.pf }}</td>
              <td>{{ log.pts }}</td>
              <td>{{ log.plus_minus }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <div v-if="activeTab === 'seasonStats'" class="tab-content mt-4">
      <div class="pagination-controls">
        <button @click="prevPage('seasonStats')" :disabled="seasonStatsPage === 1" class="btn btn-secondary btn-sm">Previous</button>
        <span>Page {{ seasonStatsPage }}</span>
        <button @click="nextPage('seasonStats')" :disabled="!hasMoreSeasonStats" class="btn btn-secondary btn-sm">Next</button>
      </div>
      <div class="table-container">
        <table v-if="seasonStats.length">
          <thead>
            <tr>
              <th>Season</th>
              <th>Team</th>
              <th>GP</th>
              <th>GS</th>
              <th>MIN</th>
              <th>PTS</th>
              <th>REB</th>
              <th>AST</th>
              <th>STL</th>
              <th>BLK</th>
              <th>TOV</th>
              <th>PF</th>
              <th>FG%</th>
              <th>3P%</th>
              <th>FT%</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="stat in seasonStats" :key="stat.season_id">
              <td>{{ stat.season_id }}</td>
              <td>{{ stat.team_abbreviation }}</td>
              <td>{{ stat.gp }}</td>
              <td>{{ stat.gs }}</td>
              <td>{{ stat.min }}</td>
              <td>{{ stat.pts }}</td>
              <td>{{ stat.reb }}</td>
              <td>{{ stat.ast }}</td>
              <td>{{ stat.stl }}</td>
              <td>{{ stat.blk }}</td>
              <td>{{ stat.tov }}</td>
              <td>{{ stat.pf }}</td>
              <td>{{ stat.fg_pct }}</td>
              <td>{{ stat.fg3_pct }}</td>
              <td>{{ stat.ft_pct }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <div v-if="activeTab === 'playoffStats'" class="tab-content mt-4">
      <div class="pagination-controls">
        <button @click="prevPage('playoffStats')" :disabled="playoffStatsPage === 1" class="btn btn-secondary btn-sm">Previous</button>
        <span>Page {{ playoffStatsPage }}</span>
        <button @click="nextPage('playoffStats')" :disabled="!hasMorePlayoffStats" class="btn btn-secondary btn-sm">Next</button>
      </div>
      <div class="table-container">
        <table v-if="playoffStats.length">
          <thead>
            <tr>
              <th>Season</th>
              <th>Team</th>
              <th>GP</th>
              <th>GS</th>
              <th>MIN</th>
              <th>PTS</th>
              <th>REB</th>
              <th>AST</th>
              <th>STL</th>
              <th>BLK</th>
              <th>TOV</th>
              <th>PF</th>
              <th>FG%</th>
              <th>3P%</th>
              <th>FT%</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="stat in playoffStats" :key="stat.season_id">
              <td>{{ stat.season_id }}</td>
              <td>{{ stat.team_abbreviation }}</td>
              <td>{{ stat.gp }}</td>
              <td>{{ stat.gs }}</td>
              <td>{{ stat.min }}</td>
              <td>{{ stat.pts }}</td>
              <td>{{ stat.reb }}</td>
              <td>{{ stat.ast }}</td>
              <td>{{ stat.stl }}</td>
              <td>{{ stat.blk }}</td>
              <td>{{ stat.tov }}</td>
              <td>{{ stat.pf }}</td>
              <td>{{ stat.fg_pct }}</td>
              <td>{{ stat.fg3_pct }}</td>
              <td>{{ stat.ft_pct }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  props: {
    player: Object,
  },
  data() {
    return {
      activeTab: 'gameLogs',
      gameLogs: [],
      seasonStats: [],
      playoffStats: [],
      gameLogsPage: 1,
      seasonStatsPage: 1,
      playoffStatsPage: 1,
      itemsPerPage: 20,
      hasMoreGameLogs: true,
      hasMoreSeasonStats: true,
      hasMorePlayoffStats: true,
    };
  },
  watch: {
    player: {
      immediate: true,
      handler(newPlayer) {
        if (newPlayer) {
          this.fetchGameLogs();
          this.fetchSeasonStats();
          this.fetchPlayoffStats();
        }
      },
    },
  },
  methods: {
    setActiveTab(tab) {
      this.activeTab = tab;
      if (tab === 'gameLogs') {
        this.fetchGameLogs();
      } else if (tab === 'seasonStats') {
        this.fetchSeasonStats();
      } else if (tab === 'playoffStats') {
        this.fetchPlayoffStats();
      }
    },
    async fetchGameLogs() {
      try {
        const response = await axios.get(`http://api.mynbaassistant.com/api/players/${this.player.id}/games`, {
          params: {
            limit: this.itemsPerPage,
            offset: (this.gameLogsPage - 1) * this.itemsPerPage,
          },
        });
        this.gameLogs = response.data;
        this.hasMoreGameLogs = response.data.length === this.itemsPerPage;
      } catch (error) {
        console.error('Error fetching game logs:', error);
      }
    },
    async fetchSeasonStats() {
      try {
        const response = await axios.get(`http://api.mynbaassistant.com/api/players/${this.player.id}/seasonstats`, {
          params: {
            limit: this.itemsPerPage,
            offset: (this.seasonStatsPage - 1) * this.itemsPerPage,
          },
        });
        this.seasonStats = response.data;
        this.hasMoreSeasonStats = response.data.length === this.itemsPerPage;
      } catch (error) {
        console.error('Error fetching season stats:', error);
      }
    },
    async fetchPlayoffStats() {
      try {
        const response = await axios.get(`http://api.mynbaassistant.com/api/players/${this.player.id}/playoffstats`, {
          params: {
            limit: this.itemsPerPage,
            offset: (this.playoffStatsPage - 1) * this.itemsPerPage,
          },
        });
        this.playoffStats = response.data;
        this.hasMorePlayoffStats = response.data.length === this.itemsPerPage;
      } catch (error) {
        console.error('Error fetching playoff stats:', error);
      }
    },
    nextPage(tab) {
      if (tab === 'gameLogs') {
        this.gameLogsPage++;
        this.fetchGameLogs();
      } else if (tab === 'seasonStats') {
        this.seasonStatsPage++;
        this.fetchSeasonStats();
      } else if (tab === 'playoffStats') {
        this.playoffStatsPage++;
        this.fetchPlayoffStats();
      }
    },
    prevPage(tab) {
      if (tab === 'gameLogs' && this.gameLogsPage > 1) {
        this.gameLogsPage--;
        this.fetchGameLogs();
      } else if (tab === 'seasonStats' && this.seasonStatsPage > 1) {
        this.seasonStatsPage--;
        this.fetchSeasonStats();
      } else if (tab === 'playoffStats' && this.playoffStatsPage > 1) {
        this.playoffStatsPage--;
        this.fetchPlayoffStats();
      }
    },
  },
};
</script>

<style scoped>
.player-details {
  padding: 20px;
}
table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
}
th, td {
  padding: 10px;
  border: 1px solid #ccc;
  text-align: left;
}
thead {
  position: sticky;
  top: 0;
  background-color: #333;
  color: #fff;
}
.table-container {
  max-height: 400px;
  overflow-y: auto;
}
.nav-tabs {
  margin-bottom: 15px;
}
.nav-tabs .nav-link {
  cursor: pointer;
}
.nav-tabs .nav-link.active {
  background-color: #007bff;
  color: white;
}
.pagination-controls {
  display: flex;
  justify-content: space-between;
  margin-bottom: 15px;
}
</style>
