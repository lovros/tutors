<template>
<div class="container teachers">
   
	<ul class="list-group">
		<div class="" v-for="teacher in teachers">
			<li class="list-group-item">
				<div>
					
					<img v-if="teacher.base64Photo" width = "50" height= "50" :src="teacher.base64Photo"
						class="img-fluid rounded-circle" alt="avatar">
					<img v-else width = "50" height= "50" src="@/assets/default-photo.png"
						class="img-fluid rounded-circle" alt="avatar">
					<span class="mx-5">{{ teacher.firstName }} {{ teacher.lastName }}</span>
					<span  style="float:right" >
						<router-link :to="/teachers/+teacher.account_id" type="button" class="btn btn-outline-info mt-1">Profile</router-link>
					</span>
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
	this.getTeachers()
  },
  
  methods: {
	getTeachers() {
		this.$http({ url: process.env.ROOT_API+'/teachers', method: 'GET'})
				.then(res => {
					this.teachers = res.data.teachers
				})
				.catch(err => {
					console.log(err)
				})
	}
  }
}
</script>

<style>
.container.teachers{
    margin: 10vh auto 0px auto
}
</style>