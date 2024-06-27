<template>
  <div class="page-container d-flex justify-content-center align-items-center vh-100">
    <div class="login-container card p-4">
      <div class="card-body">
        <div class="text-center mb-4">
          <img src="@/assets/logo.png" alt="NBA Stats App Logo" class="img-fluid" style="width: 150px;">
        </div>
        <h1 class="card-title text-center">Welcome to NBA Stats App</h1>
        <ul class="nav nav-tabs justify-content-center mb-4">
          <li class="nav-item">
            <button class="nav-link" :class="{ active: activeTab === 'login' }" @click="activeTab = 'login'">Login</button>
          </li>
          <li class="nav-item">
            <button class="nav-link" :class="{ active: activeTab === 'register' }" @click="activeTab = 'register'">Register</button>
          </li>
        </ul>
        <div v-if="activeTab === 'login'">
          <form @submit.prevent="login">
            <div class="mb-3">
              <label for="email" class="form-label">Email</label>
              <input type="email" v-model="email" class="form-control" required>
            </div>
            <div class="mb-3">
              <label for="password" class="form-label">Password</label>
              <input type="password" v-model="password" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
            <p v-if="errorMessage" class="text-danger mt-3">{{ errorMessage }}</p>
          </form>
        </div>
        <div v-if="activeTab === 'register'">
          <form @submit.prevent="register">
            <div class="mb-3">
              <label for="email" class="form-label">Email</label>
              <input type="email" v-model="email" class="form-control" required>
            </div>
            <div class="mb-3">
              <label for="password" class="form-label">Password</label>
              <input type="password" v-model="password" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Register</button>
            <p v-if="errorMessage" class="text-danger mt-3">{{ errorMessage }}</p>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      activeTab: 'login',
      email: '',
      password: '',
      errorMessage: ''
    };
  },
  methods: {
    async login() {
      try {
        console.log('Logging in with:', this.email, this.password);
        const formData = new FormData();
        formData.append('username', this.email);
        formData.append('password', this.password);

        const response = await axios.post('http://http://api.mynbaassistant.com/api/login', formData);
        const token = response.data.access_token;

        // Store the token in localStorage
        localStorage.setItem('token', token);

        // Set the default authorization header for future requests
        axios.defaults.headers.common['Authorization'] = `Bearer ${token}`;

        // Redirect to the home page
        this.$router.push({ name: 'Home' });
      } catch (error) {
        console.error('Login error:', error);
        if (error.response) {
          this.errorMessage = error.response.data.detail;
        } else {
          this.errorMessage = 'An error occurred. Please try again.';
        }
      }
    },
    async register() {
      try {
        console.log('Registering with:', this.email, this.password); // Debug log
        await axios.post('http://http://api.mynbaassistant.com/api/register', {
          email: this.email,
          password: this.password
        });

        // Auto-login after successful registration
        await this.login();
      } catch (error) {
        console.error('Registration error:', error); // Debug log
        if (error.response) {
          this.errorMessage = error.response.data.detail;
        } else {
          this.errorMessage = 'An error occurred. Please try again.';
        }
      }
    }
  }
};
</script>

<style scoped>
.page-container {
  background-color: #1a1a1a;
  height: 100vh;
}

.login-container {
  background-color: #333;
  border-radius: 10px;
}

.card-title, .nav-link {
  color: #fff;
}

.nav-link.active {
  background-color: #007bff;
  color: #fff;
}

.form-control {
  background-color: #444;
  color: #fff;
  border: 1px solid #555;
}

.btn-primary {
  background-color: #007bff;
  border: none;
}

.btn-primary:hover {
  background-color: #0056b3;
}

.text-danger {
  color: #ff6b6b;
}
</style>
