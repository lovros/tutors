<template>

  <div id="app">
    <nav class="navbar py-0 navbar-expand-lg navbar-dark bg-dark">
		  <router-link class="navbar-brand" to="/">Teachers</router-link>
		  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		  </button>
		  <div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav ml-auto">
			  <li class="nav-item">
			    <router-link class="nav-link" to="/teachers" aria-current="page">Teachers</router-link>
			  </li>
			  <li class="nav-item">
			    <router-link class="nav-link" to="/">Log in</router-link>
			  </li>
			  <li class="nav-item">
			    <router-link class="nav-link" to="/register">Register</router-link>
			  </li>
			</ul>
		  </div>
    </nav>
    <router-view/>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
.navbar{
  height: 60px;
}
</style>
