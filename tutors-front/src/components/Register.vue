<template>
   <div class="container register">
		<div class="card mx-auto">
			<div class="card-title mx-auto my-3"><h3>Register</h3></div>
			<div class="card-body" width="250px">
				<form @submit.prevent="checkForm" accept-charset="UTF-8">
					<div class="form-group">
						<input v-bind:class="{'is-invalid': firstNameError,  '': !firstNameError}" class="form-control" placeholder="First name" v-model="firstName" type="text">
						<p style="margin-top:10px;text-align:center;" class="text-danger" v-if="firstNameError">
						{{firstNameError}}
						</p>
					</div>
					
					<div class="form-group">
						<input v-bind:class="{'is-invalid': lastNameError,  '': !lastNameError}" class="form-control" placeholder="Last name" v-model="lastName" type="text">
						<p style="margin-top:10px;text-align:center;" class="text-danger" v-if="lastNameError">
						{{lastNameError}}
						</p>
					</div>
					
					<div class="form-group">
						<input v-bind:class="{'is-invalid': emailError,  '': !emailError}" class="form-control" placeholder="E-mail" v-model="email" type="text">
						<p style="margin-top:10px;text-align:center;" class="text-danger" v-if="emailError">
						{{emailError}}
						</p>
					</div>
					
					<div class="form-group">
						<input v-bind:class="{'is-invalid': passwordError,  '': !passwordError}" class="form-control" placeholder="Password" v-model="password" type="password" value="">
						<p style="margin-top:10px;text-align:center;" class="text-danger" v-if="passwordError">
						{{passwordError}}
						</p>
					</div>
					
					<select v-bind:class="{'is-invalid': accountTypeError,  '': !accountTypeError}" v-model="accountType" class="custom-select">
						<option value="" selected>I am...</option>
						<option value = "students">Student</option>
						<option value = "teachers">Teacher</option>
					</select>
					<p style="margin-top:10px;text-align:center;" class="text-danger" v-if="accountTypeError">
					{{accountTypeError}}
				    </p>
										
					<input class="btn btn-lg btn-success btn-block my-2" type="submit" value="Register">
				</form>
				<p style="margin-top:10px;text-align:center;">Already have an account?</p>
				<div style="text-align:center;"><router-link to="/" class="link-grey">Log in</router-link></div>
			</div>
		</div>
		<div class="my-3" style="text-align:center;"><router-link to="/teachers">Continue without registering</router-link></div>

	</div>
</template>

<script>
export default {
  name: 'Register',
  data () {
    return {
      firstName: '',
	  lastName: '',
	  email: '',
	  password : '',
	  accountType: '',
	  
	  firstNameError: '',
	  lastNameError: '',
	  emailError: '',
	  passwordError: '',
	  accountTypeError: ''
	  
    }
  },
  
  created () {
  },
  
  methods: {
  
	register () {
	
    const requestOptions = {
		method: 'POST',
		headers: { 
		  'Content-Type': 'application/json',
		},
		body: JSON.stringify({ firstName: this.firstName, lastName: this.lastName, email:this.email, password: this.password })
    };
	fetch(process.env.ROOT_API+'/'+this.accountType, requestOptions)
	  .then(response => response.json())
	  .then(json => {
	    console.log(json)
		// Check if email is already in database
	    if (json.email_already_exists)
          this.emailError = 'User with this email is already registered'
		else
			this.$router.push("teachers")
	  })
	
	},
	
	checkForm () {
		// Check if all fields are filled
		if (this.firstName && this.lastName && this.email && this.password && this.accountType) {
			// Reset errors
			this.firstNameError = ''
			this.lastNameError = ''
			this.emailError = ''
			this.passwordError = ''
			this.accountTypeError = ''
			
			// Check if email is already taken
			/*if (!this.emailExists()) {
				// Send register request
				this.register()
			}*/
			this.register()
			

		} else {
		
		if (!this.firstName)
			this.firstNameError = 'Enter your first name'
		else
			this.firstNameError = ''
			
		if (!this.lastName)
			this.lastNameError = 'Enter your last name'
		else
			this.lastNameError = ''
			
		if (!this.email)
			this.emailError = 'Enter your email'
		else
			this.emailError = ''
			
		if (!this.password)
			this.passwordError = 'Enter your password'
		else
			this.passwordError = ''
			
		if (!this.accountType)
			this.accountTypeError = 'Choose your account type'
		else
			this.accountTypeError = ''
			
		
		}
	},
	emailExists () {
		const requestOptions = {
			method: 'HEAD',
			headers: { 
			  'Content-Type': 'application/json',
			},
			//body: JSON.stringify({ email: this.email })

		};
		fetch(process.env.ROOT_API+'/email', requestOptions)
		  .then(response => response.json())
		  .then(json => console.log(json))
		  
		return true
	}
  }
}
</script>

<style>
.card {
  width: 330px;
}

.container.register{
    margin: 10vh auto 0px auto
}
</style>