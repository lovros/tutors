<template>
<div class="row py-5 px-4">
    <div class="col-md-5 mx-auto">
        <!-- Profile widget -->
        <div class="bg-white shadow rounded overflow-hidden">
            <div class="px-4 pt-0 pb-4 cover">
                <div class="media align-items-end profile-head">
                    <div class="profile mr-3">
						<img :src="photoUrl"  alt="..." width="130" class="rounded mb-2 img-thumbnail">
						<router-link v-if="isCurrentUser" to="/edit-profile" type="button" class="btn btn-outline-dark btn-sm btn-block">Edit profile</router-link>
					</div>
                    <div class="media-body mb-5 text-white">
                        <h4 class="mt-0 mb-0">{{ student.firstName }} {{ student.lastName}}</h4>
                        <p class="small mb-4"> <i class="fas fa-map-marker-alt mr-2"></i>Maribor</p>
                    </div>
                </div>
            </div>
			<div class="bg-light p-4 d-flex justify-content-end text-center"><div class="bg-light p-2" />
            </div>
            <div class="px-4 py-3">
                <h5 class="mb-0">About</h5>
                <div  style="white-space: pre-line" class="p-4 rounded shadow-sm bg-light">
                    <p v-if="student.about" class="mb-0">{{ student.about }}</p>
					<p v-else class="mb-0"><i>This student still didnt provide description.</i></p>
                </div>
            </div>
        </div>
    </div>
</div>
</template>

<script>
export default {
  name: 'StudentProfile',
  
  data () {
    return {
      student: {},
	  photoUrl: require('@/assets/default-photo.png'),

	  isCurrentUser: false
  
    }
  },
  
  created () {
	this.getUser()
	if(this.$store.getters.isLoggedIn)
		this.checkCurrentUser()  
  },
  
  methods: {
  	getUser() {

			this.$http({ url: process.env.ROOT_API+'/students/'+this.$route.params.id, method: 'GET'})
			.then(res => {
				if(!res.data)
					throw res
				this.student = res.data.student
				// load base64 photo
				if(res.data.base64Photo)
					this.photoUrl = res.data.base64Photo
			})
			.catch(err => {
				console.log(err)
			})
	},
	
	checkCurrentUser() {
		this.$http({ url: process.env.ROOT_API+'/auto_login', method: 'GET'})
		.then(res => {
			if(!res.data)
				throw res
			if(res.data.account.account_id == parseInt(this.$route.params.id))
				this.isCurrentUser = true
		})
		.catch(err => {
			console.log(err)
			this.isCurrentUser = false

		})		
	}
	
  },
  
}
</script>

<style>

.profile-head {
    transform: translateY(5rem)
}

.cover {
	background-color: #121212;
}
</style>