<template>
   <div class="container" >
   <img class="logo" src="../assets/logo.png"  alt="logo">
		<div class="card mx-auto">
			<div class="card-title mx-auto my-3"><h3>Log in</h3></div>
			<div class="card-body" width="250px">
			
				<form @submit.prevent="login" accept-charset="UTF-8" role="form">
					<div class="form-group">
					<input class="form-control" placeholder="E-mail" name="email" type="text">
					</div>
					<div class="form-group">
						<input class="form-control" placeholder="Password" name="password" type="password" value="">
					</div>
					<input class="btn btn-lg btn-success btn-block" type="submit" value="Login">
				</form>
				
				<p style="margin-top:10px;text-align:center;">Dont have an account?</p>
				<div style="text-align:center;"><router-link to="/register">Sign up</router-link></div>

			</div>
		</div>
		<div class="my-3" style="text-align:center;"><router-link to="/teachers">Continue without registering</router-link></div>

	</div>
</template>

<script>
export default {
  name: 'LogIn',
  data () {
    return {
      name: ''
    }
  },
  methods: {
	login () {
	
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