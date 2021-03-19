<template>
<div class="wrapper bg-white mt-sm-5">

    <h4 class="pb-4 border-bottom">Edit profile</h4>
    <div class="d-flex align-items-start py-3 border-bottom">
		<img :src="photoUrl" class="img" alt="profile photo">
		<div class="pl-sm-4 pl-2" id="img-section"> <b>Profile Photo</b>
            <p>Accepted file type .png .jpg .jpeg</p>
			<button @click="clickFileInput" class="btn btn-outline-info">Upload</button>
			<input ref="fileInput" @change="photoChanged($event)" type="file" accept=".png, .jpg, .jpeg" name="name" style="display: none;" />
		</div>
    </div>
    <div class="py-2">
        <div class="row py-2">
            <div class="col-md-6">
				<label for="firstname">First Name</label>
				<input v-model="user.firstName" v-bind:class="{'is-invalid': firstNameError,  '': !firstNameError}"  type="text" class="bg-light form-control">
				<p style="margin-top:10px;text-align:center;" class="text-danger" v-if="firstNameError">
				{{firstNameError}}
				</p>
			</div>
            <div class="col-md-6 pt-md-0 pt-3">
				<label for="lastname">Last Name</label>
				<input v-model="user.lastName" v-bind:class="{'is-invalid': lastNameError,  '': !lastNameError}" type="text" class="bg-light form-control">
				<p style="margin-top:10px;text-align:center;" class="text-danger" v-if="lastNameError">
				{{lastNameError}}
				</p>
			</div>
        </div>
        <div class="row py-2 form-group">
			<div class="col-md-12">
				<label for="aboutTextArea">About</label> 
				<textarea v-model="user.about" class="bg-light form-control" id="aboutTextArea" rows="3" :placeholder="aboutPlaceholder"></textarea>
			</div>
		</div>

        <div class="py-3 pb-4">
			<button class="btn btn-success mt-1" @click="checkForm()">Save changes</button>
			<router-link v-if="this.$store.state.account_type=='Teacher'" :to="/teachers/+user.account_id" class="btn btn-outline-secondary mt-1" >Cancel</router-link>
			<router-link v-if="this.$store.state.account_type=='Student'" :to="/students/+user.account_id" class="btn btn-outline-secondary mt-1" >Cancel</router-link>
		</div>

    </div>
</div>
</template>

<script>
export default {
  name: 'EditProfile',
  data () {
    return {
	  user: {},
	  photoUrl: require('@/assets/default-photo.png'),
	  
	  firstNameError: '',
	  lastNameError: '',
	  aboutError: '',
	  photoError: '',
	  
	  aboutPlaceholder: 'Say something about yourself'
	  
    }
  },
  
  created () {
    if(this.$store.state.account_type == "Teacher") {
	    this.aboutPlaceholder = "Tell your students about yourself"
	}
	this.getCurrentUser()
	
  },
  
  methods: {
  
	getCurrentUser () {
		this.$http({ url: process.env.ROOT_API+'/auto_login', method: 'GET'})
		.then(res => {
			if(!res.data)
				throw res
			this.user = res.data.account
			this.user.photo = ""
			// load base64 photo
			if(res.data.base64Photo)
				this.photoUrl = 'data:image/jpeg;base64,' + res.data.base64Photo
			
		})
		.catch(err => {
			console.log(err)
			this.isCurrentUser = false
		})			
	},
	
	checkForm () {				
		// Check if all required fields are filled
		if (this.user.firstName && this.user.lastName) {
			// Reset errors
			this.firstNameError = ''
			this.lastNameError = ''

			this.update()
		} else {
		
			if (!this.user.firstName)
				this.firstNameError = 'Enter your first name'
			else
				this.firstNameError = ''
				
			if (!this.user.lastName)
				this.lastNameError = 'Enter your last name'
			else
				this.lastNameError = ''
		}
	},
	
	clickFileInput() {
		this.$refs.fileInput.click();
	},
	
	photoChanged(event) {
		this.photoUrl = URL.createObjectURL(event.target.files[0])
		
		this.getBase64StringFromFile(event.target.files[0]).then(res => {
			this.user.photo = res
		}).catch(err => {
			console.log(err)
		})
	},
	
	// TODO: move to helper class
	async getBase64StringFromFile(file){
		return new Promise((resolve, reject) => {
			var reader = new FileReader();
			reader.onload = function(e) {
				let binaryString = e.target.result;
				let base64String = "data:image/png;base64," + btoa(binaryString)
				return resolve(base64String)
			};
			reader.onerror = function(e) {
				return reject(e.type);
			};
			reader.readAsBinaryString(file);
		})
	},
	
	update() {
		this.$http({ url: process.env.ROOT_API+'/accounts/update', data:this.user, method: 'POST'})
		.then(res => {
			if(!res.data)
				throw res
			if(this.$store.state.account_type == "Teacher")
				this.$router.push("teachers/"+this.user.account_id)
			else if(this.$store.state.account_type == "Student")
				this.$router.push("students/"+this.user.account_id)
			else
				console.log("Unknown user type " + this.$store.state.account_type)

		})
		.catch(err => {
			console.log(err)
		})
	}
	
  }
}
</script>

<style>

.wrapper {
    padding: 30px 50px;
    border: 1px solid #ddd;
    border-radius: 15px;
    margin: 10px auto;
    max-width: 600px
}


.img {
    width: 70px;
    height: 70px;
    border-radius: 6px;
    
	object-fit: cover
}

</style>