class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :update, :destroy]

  # GET /students
  def index
    @students = Student.all

    render json: @students
  end

  # GET /students/1
  def show
    render json: @student
  end

  # POST /students
  def create
    @student = Student.new(student_params)
	@student.password = params[:password]
	@student.password_confirmation = params[:password]
	
	
	# Check if mail already exists in database, explicit parameter prevents SQL injection
	if (Student.find_by_email(params[:email]).nil? and Teacher.find_by_email(params[:email]).nil?)
		if @student.save
		  render json: @student, status: :created, location: @student
		else
		  render json: @student.errors, status: :unprocessable_entity
		end
	else
	  render json: {'email_already_exists' => 'true'}, status: :unprocessable_entity
	end
  end

  # PATCH/PUT /students/1
  def update
    if @student.update(student_params)
      render json: @student
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # DELETE /students/1
  def destroy
    @student.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def student_params
      params.require(:student).permit(:firstName, :lastName, :email, :password, :photo, :appointments_id)
    end
end
