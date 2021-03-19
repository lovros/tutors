<template>
   <div class="container" >
   <img class="logo" src="../assets/logo.png" alt="logo">
		<div v-if="!isLoggedIn">
		<div class="card mx-auto">
			<div class="card-title mx-auto my-3"><h3>Log in</h3></div>
			<div class="card-body" width="250px">
			
				<form @submit.prevent="login" accept-charset="UTF-8" role="form">
					<div class="form-group">
					<input v-bind:class="{'is-invalid': emailError,  '': !emailError}" class="form-control" placeholder="E-mail" v-model="email" name="email" type="text"/>
						<p style="margin-top:10px;text-align:center;" class="text-danger" v-if="emailError">
						{{emailError}}
						</p>
					</div>
					<div class="form-group">
						<input v-bind:class="{'is-invalid': passwordError,  '': !passwordError}" class="form-control" placeholder="Password" v-model="password" name="password" type="password" value=""/>
						<p style="margin-top:10px;text-align:center;" class="text-danger" v-if="passwordError">
						{{passwordError}}
						</p>
					</div>
					<input class="btn btn-lg btn-success btn-block" type="submit" value="Login">
				</form>
				
				<p style="margin-top:10px;text-align:center;">Dont have an account?</p>
				<div style="text-align:center;"><router-link to="/register">Sign up</router-link></div>

			</div>
		</div>
		<div class="my-3" style="text-align:center;"><router-link to="/teachers">Continue without registering</router-link></div>
        </div>
	</div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'LogIn',
  
  data () {
    return {
      email: '',
	  password: '',
	  
	  emailError: '',
	  passwordError: ''
    }
  },
  computed: {
	  isLoggedIn: function() {
	    return this.$store.getters.isLoggedIn;
	  } 
  },
  
  methods: {
	login () {
	  this.emailError = ''
	  this.passwordError = ''
	  
	  // Log out
	  this.$store.dispatch('logout').then(() => {
		  // Log in
		  var credentials = {email:this.email, password: this.password }
		  this.$store.dispatch("login", credentials)
			.then((res) => {
				this.$router.push("teachers")			
			})
			.catch((err) => {
				console.log(this.$store.state.status)
				if(!err.data)
					return
				if (err.data.emailError)
				  this.emailError = 'Account with this email doesn\'t exist'
				else if(err.data.passwordError)
				  this.passwordError = 'Invalid password'
			})
	  })
	}
  
  }
  
}
</script>

<style>
.card {
  width: 330px;
}

img.logo{
    display: block;
    margin:0 auto;
	width:300px;
}
</style>