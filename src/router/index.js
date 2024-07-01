import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/HomePage.vue';
import AuthPage from '../views/AuthPage.vue';
import YahooSignIn from '../views/YahooSignIn.vue';
import YahooHome from '../views/YahooHome.vue';
import VerifierCode from '../views/VerifierCode.vue';

const routes = [
  {
    path: '/',
    name: 'AuthPage',
    component: AuthPage
  },
  {
    path: '/home',
    name: 'Home',
    component: Home
  },
  {
    path: '/yahoo-signin',
    name: 'YahooSignIn',
    component: YahooSignIn
  },
  {
    path: '/yahoo-verifier',
    name: 'VerifierCode',
    component: VerifierCode
  },
  {
    path: '/yahoo-home',
    name: 'YahooHome',
    component: YahooHome
  },
  // other routes
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

export default router;

router.beforeEach((to, from, next) => {
  const token = localStorage.getItem('token');
  
  if (to.name !== 'AuthPage' && !token) {
    next({ name: 'AuthPage' });
  } else {
    next();
  }
});
