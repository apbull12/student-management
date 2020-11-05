class StudentsController < ApplicationController
  include StudentsHelper
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET /students
  # GET /students.json
  def index
    if params[:query]
      @students = Student.where('name ILIKE ? AND user_id = ?', "%#{params[:query]}%", current_user.id)
      logger.debug "searching the student for query #{params[:query]}..."
    else
      @students = Student.where(user_id: current_user.id)
    end
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)
    logger.debug "New Student: #{@student.attributes.inspect}"

    respond_to do |format|
      @student.user_id = current_user.id
      if StudentsHelper.existing_subject(@student.attributes) || @student.save
        logger.debug "The Student was saved and now the user is going to be redirected..."
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if StudentsHelper.existing_subject(student_params.merge!(user_id: current_user.id)) || @student.update(student_params)
        logger.debug "The Student was updated #{@student.attributes.inspect} and now the user is going to be redirected..."
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:name, :subject, :mark, :query)
    end
end
