// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import App from './App'
import router from './router'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import Axios from 'axios'
import store from './store'

Vue.prototype.$http = Axios;
const token = localStorage.getItem('token')
if(token){
	Vue.prototype.$http.defaults.headers.common['Authorization'] = 'Bearer '+token
}


Vue.use(BootstrapVue)
Vue.use(IconsPlugin)


Vue.config.productionTip = false
/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  components: { App },
  template: '<App/>'
})
