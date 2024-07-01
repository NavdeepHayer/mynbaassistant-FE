<template>
  <div class="yahoo-home container-fluid">
    <h1>Welcome to Yahoo Fantasy Home</h1>
    <div v-if="leagues && leagues.length > 0">
      <h2>Your Leagues</h2>
      <ul>
        <li v-for="league in leagues" :key="league.league_id">{{ league.name }}</li>
      </ul>
    </div>
    <div v-else>
      <p>No leagues found or not authenticated yet.</p>
    </div>
  </div>
</template>

<script>
export default {
  name: 'YahooHome',
  data() {
    return {
      leagues: null
    };
  },
  async created() {
    try {
      const leagues = JSON.parse(localStorage.getItem('leagues'));
      if (leagues) {
        this.leagues = leagues;
      } else {
        // Optionally, you can add logic to redirect back to sign-in if no leagues are found.
        console.log('No leagues found in local storage.');
      }
    } catch (error) {
      console.error('Error fetching leagues:', error);
      alert('An error occurred while fetching your leagues');
    }
  }
}
</script>

<style scoped>
.yahoo-home {
  width: 100%;
  padding: 0 15px;
  background-color: #121212;
  color: #e0e0e0;
}
</style>
