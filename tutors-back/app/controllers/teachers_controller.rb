class TeachersController < ApplicationController
  before_action :set_teacher, only: [:show]
  skip_before_action :authorized, only: [:index, :show]
  # GET /teachers
  def index
    # Join teachers with accounts
  	@teacher_joined = Teacher.joins(:account).select("teachers.*,
		accounts.id AS account_id")
		
	responseJson = JSON.parse('{
	  "teachers": [
	  ]
	}')
	@teacher_joined.each do |t|
	  base64Photo = ""
	  unless t.photo.file.nil?
	    base64Photo = "data:image/png;base64," + Base64.encode64(File.open(t.photo.path, 'rb').read)
	  end
	  teacherHash = t.as_json
	  teacherHash["base64Photo"] = base64Photo
	  teacherJson = JSON.parse(teacherHash.to_json)
	  responseJson["teachers"] << teacherJson
	end
    render json: responseJson
  end

  # GET /teachers/1
  def show
    base64Photo = ""
	unless @teacher.photo.file.nil?
	  base64Photo = "data:image/png;base64," + Base64.encode64(File.open(@teacher.photo.path, 'rb').read)
	end
    render json:{teacher: @teacher, base64Photo: base64Photo}
  end


  private
    # Use callbacks to share common setup or constraints between actions.
	# Join teachers with accounts, find teacher by account id
    def set_teacher
    @teacher = Teacher.joins(:account).select("teachers.*, teachers.id,
	  accounts.id AS account_id").where("accounts.id": params[:id]).first
	end

end
