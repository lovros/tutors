import Vue from 'vue'
import Router from 'vue-router'
import store from '../store'
import LogIn from '@/components/LogIn'
import Register from '@/components/Register'
import Teachers from '@/components/Teachers'
import TeacherProfile from '@/components/TeacherProfile'
import StudentProfile from '@/components/StudentProfile'
import EditProfile from '@/components/EditProfile'

Vue.use(Router)

let router = new Router({
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
	{
      path: '/teachers/:id',
      name: 'TeacherProfile',
      component: TeacherProfile,
    },
	{
      path: '/students/:id',
      name: 'StudentProfile',
      component: StudentProfile,	 
	  meta: {
		  requiresAuth: true
	  }
    },
	{
      path: '/edit-profile',
      name: 'EditProfile',
      component: EditProfile,
	  meta: {
		  requiresAuth: true
	  }
    },
  ]
})

// Handle authorized routes
router.beforeEach((to, from, next) => {
	if(to.matched.some(record => record.meta.requiresAuth)){
		if (store.getters.isLoggedIn) {
			next()
			return
		}
		next('/')
	} else {
		next()
	}
})

export default router