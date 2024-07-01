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
    </div>
  </template>
  
  <script>
  export default {
    name: 'VerifierCode',
    data() {
      return {
        verifier: '',
      };
    },
    methods: {
      async submitVerifier() {
        try {
          const response = await fetch('https://api.mynbaassistant.com/auth/yahoo/verifier', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
              verifier: this.verifier
            })
          });
          const data = await response.json();
  
          if (data.token) {
            // Store token and leagues in local storage
            localStorage.setItem('access_token', data.token);
            localStorage.setItem('leagues', JSON.stringify(data.leagues));
  
            // Redirect to Yahoo Home page
            this.$router.push({ name: 'YahooHome' });
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
  