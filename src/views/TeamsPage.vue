<template>
  <div class="teams-page">
    <h2>NBA Teams</h2>
    <div class="table-wrapper">
      <table>
        <thead>
          <tr>
            <th>Team ID</th>
            <th>Season</th>
            <th>City</th>
            <th>Nickname</th>
            <th>Abbreviation</th>
            <th>Conference</th>
            <th>Division</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="team in teams" :key="team.team_id">
            <td>{{ team.team_id }}</td>
            <td>{{ team.season }}</td>
            <td>{{ team.city }}</td>
            <td>{{ team.nickname }}</td>
            <td>{{ team.abbreviation }}</td>
            <td>{{ team.conference }}</td>
            <td>{{ team.division }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'TeamsPage',
  data() {
    return {
      teams: []
    };
  },
  async created() {
    try {
      const response = await axios.get('http://192.168.50.157:8000/api/teams');
      this.teams = response.data;
    } catch (error) {
      if (error.response) {
        // The request was made and the server responded with a status code
        console.error('Error response status:', error.response.status);
        console.error('Error response data:', error.response.data);
      } else if (error.request) {
        // The request was made but no response was received
        console.error('No response received:', error.request);
      } else {
        // Something else happened in making the request that triggered an error
        console.error('Error message:', error.message);
      }
      console.error('Error config:', error.config);
    }
  }
};
</script>

<style>
.teams-page {
  max-width: 800px;
  margin: 0 auto;
  text-align: center;
}

.table-wrapper {
  margin-top: 20px;
  overflow-x: auto;
}

table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 10px;
  font-size: 14px;
}

th, td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: center;
}

th {
  background-color: #f4f4f4;
}

thead th {
  position: -webkit-sticky;
  position: sticky;
  top: 0;
  z-index: 1;
  background-color: #333;
  color: white;
}
</style>
