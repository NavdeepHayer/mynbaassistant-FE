<template>
  <div class="yahoo-signin container-fluid">
    <h1>Yahoo Fantasy Sign In</h1>
    <button class="btn btn-primary" @click="signInWithYahoo">Sign In with Yahoo</button>
  </div>
</template>

<script>
export default {
  name: 'YahooSignIn',
  methods: {
    async signInWithYahoo() {
      try {
        const response = await fetch('https://api.mynbaassistant.com/auth/yahoo-auth');
        const data = await response.json();
        if (data.auth_url) {
          window.location.href = data.auth_url;
        } else {
          alert('Failed to get Yahoo authentication URL');
        }
      } catch (error) {
        console.error('Error during Yahoo authentication:', error);
        alert('An error occurred during Yahoo authentication');
      }
    }
  }
}
</script>

<style scoped>
.yahoo-signin {
  width: 100%;
  padding: 0 15px;
  background-color: #121212;
  color: #e0e0e0;
}
</style>
