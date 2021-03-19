import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

export default new Vuex.Store({
	state: {
		status: 'fresh',
		token: localStorage.getItem('token') || '',
		account_id: localStorage.getItem('account_id') || '',
		account_type: localStorage.getItem('account_type') || ''
	},
	mutations: {
		auth_request(state) {
			state.status = 'pending'
		},
		auth_success(state, {token, id, account_type}) {
			state.status = 'success'
			state.token = token
			state.account_id = id
			state.account_type = account_type
		},
		auth_error(state) {
			state.status = 'error'
		},
		logout(state) {
			state.status = ''
			state.token = ''
			state.account_id = ''
			state.account_type = ''
		}
		
	},
	actions: {
		login({commit}, credentials) {
			commit('auth_request')
			return new Promise((resolve, reject) => {
				  axios({ url: process.env.ROOT_API+'/login', data: credentials, method: 'POST'})
					.then(res => {
						const token = res.data.token
						const id = res.data.account_id
						const account_type = res.data.account_type
						// If the server didnt return a valid user
						if(!id){
							commit('auth_error')
							localStorage.removeItem('token')
							localStorage.removeItem('account_id')
							localStorage.removeItem('account_type')

							return reject(res)
						}
						localStorage.setItem('token', token)
						localStorage.setItem('account_id', id)
						localStorage.setItem('account_type', account_type)

						axios.defaults.headers.common['Authorization'] = 'Bearer ' + token
						commit('auth_success', {token, id, account_type})
						resolve(res)
					})
					.catch(err => {
						commit('auth_error')
						localStorage.removeItem('token')
						localStorage.removeItem('account_id')
						localStorage.removeItem('account_type')

						reject(err)
					})
			})
		},
		
		register({commit}, user) {
			return new Promise((resolve, reject) => {
				axios({ url: process.env.ROOT_API+'/accounts', data: user, method: 'POST'})
					.then(res => {
						const token = res.data.token
						const id = res.data.account_id
						const account_type = res.data.account_type
						// If the server didnt return a valid user
						if(!id){
							commit('auth_error')
							localStorage.removeItem('token')
							localStorage.removeItem('account_id')
							localStorage.removeItem('account_type')

							return reject(res)
						}
						localStorage.setItem('token', token)
						localStorage.setItem('account_id', id)
						localStorage.setItem('account_type', account_type)


						axios.defaults.headers.common['Authorization'] = 'Bearer ' + token
						commit('auth_success', {token, id, account_type})
						resolve(res)
					})
					.catch(err => {
						commit('auth_error')
						localStorage.removeItem('token')
						localStorage.removeItem('account_id')
						localStorage.removeItem('account_type')

						reject(err)
					})
			})
		},
		
		logout({commit}) {
			return new Promise((resolve, reject) => {
				commit('logout')
				localStorage.removeItem('token')
				localStorage.removeItem('account_id')
				localStorage.removeItem('account_type')

				delete axios.defaults.headers.common['Authorization']
				resolve()
			})
		}
		
	},
	getters: {
		isLoggedIn: state => !!state.token,
		authStatus: state => state.status,
	}
})