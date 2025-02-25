class StudentsController < ApplicationController
  def index
    @students = Student.all.order(created_at: :desc)
    render({ template: "students/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @student = Student.where(id: the_id).first  # ✅ Using `.where(...).first`

    if @student.nil?
      flash[:alert] = "Student not found."
      redirect_to("/students") and return
    end

    render({ template: "students/show" })
  end

  def create
    @student = Student.new
    @student.first_name = params.fetch("query_first_name")
    @student.last_name = params.fetch("query_last_name")
    @student.email = params.fetch("query_email")

    if @student.save
      flash[:notice] = "Student created successfully."
    else
      flash[:alert] = "Student failed to create successfully."
    end
    redirect_to("/students")
  end

  def update
    the_id = params.fetch("path_id")
    @student = Student.where(id: the_id).first

    if @student.nil?
      flash[:alert] = "Student not found."
      redirect_to("/students") and return
    end

    @student.first_name = params.fetch("query_first_name")
    @student.last_name = params.fetch("query_last_name")
    @student.email = params.fetch("query_email")

    if @student.save
      flash[:notice] = "Student updated successfully."
      redirect_to("/students/#{@student.id}")
    else
      flash[:alert] = "Student failed to update successfully."
      redirect_to("/students")
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @student = Student.where(id: the_id).first  

    if @student.nil?
      flash[:alert] = "Student not found."
    else
      @student.destroy
      flash[:notice] = "Student deleted successfully."
    end

    redirect_to("/students")
  end
end
