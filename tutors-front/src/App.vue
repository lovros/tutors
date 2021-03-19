<template>

  <div id="app">
    <nav style="background-color: #121212!important;" class="navbar py-0 navbar-expand-lg navbar-dark">
		  <router-link class="navbar-brand" to="/">Tutors</router-link>
		  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		  </button>
		  <div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav ml-auto">
			  <li class="nav-item">
			    <router-link class="nav-link" to="/teachers" aria-current="page">Teachers</router-link>
			  </li>
			  <li v-if="!isLoggedIn" class="nav-item">
			    <router-link class="nav-link" to="/">Log in</router-link>
			  </li>
			  <li v-if="!isLoggedIn" class="nav-item">
			    <router-link class="nav-link" to="/register">Register</router-link>
			  </li>
			  <li v-if="isLoggedIn" class="nav-item">
			    <router-link v-if="getType=='Teacher'" class="nav-link" :to="{ name: 'TeacherProfile', params: { id: this.$store.state.account_id }}">My profile</router-link>
				<router-link v-if="getType=='Student'" class="nav-link" :to="{ name: 'StudentProfile', params: { id: this.$store.state.account_id }}">My profile</router-link>

			  </li>
			  <li v-if="isLoggedIn" class="nav-item">
			    <a @click="logout" class="nav-link" >Log out</a>
			  </li>
			</ul>
		  </div>
    </nav>
    <router-view :key="$route.fullPath" />
  </div>
</template>

<script>
export default {
	name: 'App',
	
	computed: {
		isLoggedIn: function() {
		  return this.$store.getters.isLoggedIn;
		},
		
		getType: function() {
		  return this.$store.state.account_type;

		}
	},
	
	methods: {
		logout: function() {
		  this.$store.dispatch("logout").then(() => {
		    if (this.$route.path !== "/")
			  this.$router.push("/");
		  });
		}
	}
}
</script>

<style>
.navbar{
  height: 60px;
}
li:hover {
    cursor: pointer;
}
</style>
