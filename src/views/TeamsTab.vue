<template>
  <div class="teams-tab container">
    <h2 class="text-center my-4">NBA Teams</h2>
    <div class="row">
      <div v-for="team in teams" :key="team.team_id" class="col-md-4 mb-4">
        <div class="card bg-dark text-white">
          <div class="card-body">
            <h5 class="card-title">{{ team.city }} {{ team.nickname }}</h5>
            <p class="card-text">{{ team.conference }} - {{ team.division }}</p>
            <button class="btn btn-primary" @click="toggleCard(team.team_id)">
              View Players
            </button>
            <div v-if="isFlipped[team.team_id]" class="player-list mt-3">
              <ul class="list-group">
                <li
                  v-for="player in selectedTeamPlayers[team.team_id]"
                  :key="player.id"
                  @click="selectPlayer(player)"
                  class="list-group-item list-group-item-action"
                >
                  {{ player.full_name }}
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'TeamsTab',
  data() {
    return {
      teams: [],
      isFlipped: {},
      selectedTeamPlayers: {},
    };
  },
  async created() {
    this.fetchTeams();
  },
  methods: {
    async fetchTeams() {
      try {
        const response = await axios.get('https://api.mynbaassistant.com/api/teams', {
          headers: {
            Authorization: `Bearer ${localStorage.getItem('token')}`,
          },
        });
        this.teams = response.data;
      } catch (error) {
        console.error('Error fetching NBA teams:', error);
      }
    },
    async fetchPlayersByTeam(teamId) {
      try {
        const response = await axios.get(`https://api.mynbaassistant.com/api/teams/${teamId}/players`, {
          headers: {
            Authorization: `Bearer ${localStorage.getItem('token')}`,
          },
        });
        this.$set(this.selectedTeamPlayers, teamId, response.data);
      } catch (error) {
        console.error('Error fetching players for the team:', error);
      }
    },
    async toggleCard(teamId) {
      if (!this.selectedTeamPlayers[teamId]) {
        await this.fetchPlayersByTeam(teamId);
      }
      this.$set(this.isFlipped, teamId, !this.isFlipped[teamId]);
    },
    selectPlayer(player) {
      this.$emit('select-player', player);
    },
  },
};
</script>

<style scoped>
.card {
  background-color: #333;
  color: #fff;
}

.card-title, .card-text {
  color: #fff;
}

.list-group-item {
  cursor: pointer;
  background-color: #2a2a2a;
  color: #fff;
}

.list-group-item:hover {
  background-color: #444;
}

.player-list {
  margin-top: 20px;
}
</style>
