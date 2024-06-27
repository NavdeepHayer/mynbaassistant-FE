<template>
  <div class="players-tab container-fluid">
    <div class="row h-100">
      <div class="col-3 h-100">
        <SearchResults @select-player="selectPlayer" />
      </div>
      <div class="col-9 h-100">
        <PlayerDetails :player="selectedPlayer" v-if="selectedPlayer" />
        <div v-else class="no-player-selected">Please select a player from the list.</div>
      </div>
    </div>
  </div>
</template>

<script>
import SearchResults from './SearchResults.vue';
import PlayerDetails from './PlayerDetails.vue';

export default {
  name: 'PlayersTab',
  components: {
    SearchResults,
    PlayerDetails
  },
  data() {
    return {
      selectedPlayer: null
    };
  },
  methods: {
    selectPlayer(player) {
      this.selectedPlayer = player;
    }
  }
};
</script>

<style scoped>
.players-tab {
  padding: 15px;
  background-color: #1a1a1a; /* Match the dark theme */
  color: #e0e0e0; /* Light text color */
  border-radius: 8px; /* Rounded corners for modern look */
  height: 100vh; /* Full height */
}
.no-player-selected {
  padding: 20px;
  color: #ccc;
  text-align: center;
}
</style>
