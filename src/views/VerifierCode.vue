<template>
    <div class="verifier-form container-fluid">
      <h1>Yahoo OAuth Verifier</h1>
      <form @submit.prevent="submitVerifier">
        <div class="form-group">
          <label for="verifier">Enter the code from Yahoo:</label>
          <input type="text" class="form-control" id="verifier" v-model="verifier" required>
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
      </form>
      <button class="btn btn-secondary mt-3" @click="goBack">Back</button>
      <div v-if="leagues && leagues.length > 0">
        <h2>Your Leagues</h2>
        <ul>
          <li v-for="league in leagues" :key="league">{{ league }}</li>
        </ul>
      </div>
      <div v-else-if="leagues !== null">
        <p>No leagues found or not authenticated yet.</p>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    name: 'VerifierCode',
    data() {
      return {
        verifier: '',
        token: null,
        leagues: null,
      };
    },
    created() {
      const urlParams = new URLSearchParams(window.location.search);
      const verifierCode = urlParams.get('code');
      if (verifierCode) {
        this.verifier = verifierCode;
        this.submitVerifier();
      }
    },
    methods: {
      async submitVerifier() {
        console.log('Submitting verifier code:', this.verifier); // Debug log
        try {
          const response = await fetch('http://api.mynbaassistant.com/auth/yahoo/verifier', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
              verifier: this.verifier
            })
          });
          console.log('Response received:', response); // Debug log
          const data = await response.json();
          console.log('Data received:', data); // Debug log
  
          if (data.token) {
            this.token = data.token;
            this.leagues = data.leagues;
  
            // Optionally, store the token in local storage
            localStorage.setItem('access_token', this.token);
          } else {
            alert('Failed to authenticate with Yahoo');
          }
        } catch (error) {
          console.error('Error during Yahoo verifier processing:', error);
          alert('An error occurred during Yahoo verifier processing');
        }
      },
      goBack() {
        this.$router.push({ name: 'YahooSignIn' });
      }
    }
  };
  </script>
  
  <style scoped>
  .verifier-form {
    width: 100%;
    padding: 0 15px;
    background-color: #121212;
    color: #e0e0e0;
  }
  </style>
  