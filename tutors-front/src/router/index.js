import Vue from 'vue'
import Router from 'vue-router'
import LogIn from '@/components/LogIn'
import Register from '@/components/Register'
import Teachers from '@/components/Teachers'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'LogIn',
      component: LogIn
    },
	{
      path: '/register',
      name: 'Register',
      component: Register
    },
	{
      path: '/teachers',
      name: 'Teachers',
      component: Teachers
    },
  ]
})
