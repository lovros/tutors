class AccountsController < ApplicationController
  before_action :authorized, :set_account_joined, only: [:auto_login, :update]

  # Register
  def create
	if params["accountType"].downcase == "teacher"
	  @account_user = Teacher.create!(firstName: params["firstName"], lastName: params["lastName"])
	else
	  @account_user = Student.create!(firstName: params["firstName"], lastName: params["lastName"])
	end
    
	@account = Account.new(email: params["email"], password: params["password"])
	@account.account_user = @account_user
	@account.save	
	if @account.valid?
	  token = encode_token({account_id: @account.id})
	  render json: {account_id: @account.id, token: token, account_type: @account.account_user_type}
	else
	  # Rollback
	  if params["accountType"].downcase == "teacher"
	    Teacher.destroy(@account_user.id)
	  else
	    Student.destroy(@account_user.id)
	  end
	  render json: {emailAlreadyExists: "Email already exists"}
	end
  end
  
  # Log in
  def login
    @account = Account.find_by(email: params[:email])
	
	if not @account
	  render json:{emailError: "This email does not exist"}
	elsif not @account.authenticate(params[:password])
	  render json:{passwordError: "Invalid password"}
	else
	  token = encode_token({account_id: @account.id})
	  render json: {account_id: @account.id, token: token, account_type: @account.account_user_type}
	end
  end
  
  def auto_login
    base64Photo = ""
  	unless @account_joined.photo.file.nil?
	  base64Photo = Base64.encode64(File.open(@account_joined.photo.path, 'rb').read)
	end
	render json: {account: @account_joined, base64Photo: base64Photo}
  end
  
  def account_params
    params.permit(:firstName, :lastName, :email, :password, :accountType)
  end
  
  def update
    if @account.account_user_type == "Teacher"
	  @user = Teacher.find(@account_joined.id)
	  @user.update_attributes(:firstName => params[:firstName], :lastName => params[:lastName], :about => params[:about])
	  if params[:photo]
	    @user.photo = params[:photo]
		@user.save!
	  end
	elsif @account.account_user_type == "Student"
      @user = Student.find(@account_joined.id)
	  @user.update_attributes(:firstName => params[:firstName], :lastName => params[:lastName], :about => params[:about])
	  if params[:photo]
	    @user.photo = params[:photo]
		@user.save!
	  end
	else
	  puts "unknown user type " + @account.account_user_type
	  render json: {userTypeError: "Unknown user type"}
	end
    render json: @user
  end
  
    private
    # Use callbacks to share common setup or constraints between actions.
	# Join account with user
    def set_account_joined
	  account_id = @account.id
	  if @account.account_user_type == "Teacher"
	    @account_joined = Teacher.joins(:account).select("teachers.*, teachers.id,
		accounts.id AS account_id").where("accounts.id": account_id).first
	  elsif @account.account_user_type == "Student"
      @account_joined = Student.joins(:account).select("students.*, students.id,
	    accounts.id AS account_id").where("accounts.id": account_id).first
	  else
	    puts "unknown user type " + @account.account_user_type
	    @account_joined = @account
	  end
	end
end
