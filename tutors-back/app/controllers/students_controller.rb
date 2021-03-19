class StudentsController < ApplicationController
  before_action :set_student, only: [:show]

  # GET /students/1
  def show
    base64Photo = ""
	unless @student.photo.file.nil?
	  base64Photo = "data:image/png;base64," + Base64.encode64(File.open(@student.photo.path, 'rb').read)
	end
    render json:{student: @student, base64Photo: base64Photo}  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
	  @student = Student.joins(:account).select("students.*, students.id,
		  accounts.id AS account_id").where("accounts.id": params[:id]).first
    end

end
