<template>
<div class="container teachers">
   
	<ul class="list-group">

   <div class="" v-for="teacher in teachers">
	    <li class="list-group-item">
			<div>
				
				<img width = "50" height= "50" src="../assets/default-photo.png"
					class="img-fluid rounded-circle" alt="avatar">
				<span class="mx-5">{{ teacher.firstName }} {{ teacher.lastName }}</span>

			</div>
		</li>
  </div>
  </ul>

  
</div>
</template>

<script>
export default {
  name: 'Teachers',
  
  data () {
    return {
      teachers: [],
  
    }
  },
  
  created () {
  
	console.log("created called")
    const requestOptions = {
		method: 'GET',
		headers: { 
		  'Content-Type': 'application/json',
		},
    };
	
	fetch(process.env.ROOT_API+'/teachers', requestOptions)
	  .then(response => response.json())
	  .then(data => {
		this.teachers = data
	  })
	  
  },
  
  methods: {
  
	
  }
}
</script>

<style>
.container.teachers{
    margin: 10vh auto 0px auto
}
</style>