<template>
    <div class="yahoo-callback container-fluid">
      <p>Processing Yahoo authentication...</p>
    </div>
  </template>
  
  <script>
  export default {
    name: 'YahooCallback',
    async created() {
      const urlParams = new URLSearchParams(window.location.search);
      const code = urlParams.get('code');
      if (code) {
        try {
          const response = await fetch(`http://api.mynbaassistant.com/auth/yahoo/callback?code=${code}`);
          const data = await response.json();
          if (data.token) {
            localStorage.setItem('access_token', data.token.access_token);
            this.$router.push({ name: 'YahooHome' });
          } else {
            alert('Failed to authenticate with Yahoo');
            this.$router.push({ name: 'YahooSignIn' });
          }
        } catch (error) {
          console.error('Error during Yahoo callback processing:', error);
          alert('An error occurred during Yahoo callback processing');
          this.$router.push({ name: 'YahooSignIn' });
        }
      } else {
        alert('No authorization code found');
        this.$router.push({ name: 'YahooSignIn' });
      }
    }
  }
  </script>
  
  <style scoped>
  .yahoo-callback {
    width: 100%;
    padding: 0 15px;
    background-color: #121212;
    color: #e0e0e0;
  }
  </style>
  