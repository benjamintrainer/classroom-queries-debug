class CoursesController < ApplicationController
  def index
    @courses = Course.order(created_at: :desc)
    render({ template: "courses/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @course = Course.where({ :id => the_id}).at(0)

    render({ template: "courses/show" })
  end

  def create
    @course = Course.new
    @course.title = params.fetch("query_title")
    @course.term_offered = params.fetch("query_term")  
    @course.department_id = params.fetch("query_department_id")

    if @course.save 

      redirect_to("/courses")
    else
      redirect_to("/courses")
    end
  end

  def update
    the_id = params.fetch("path_id")  
    @course = Course.where({ :id => the_id}).at(0)  

    if @course.present?
      @course.update(
        title: params.fetch("query_title"),
        term_offered: params.fetch("query_term_offered"),
        department_id: params.fetch("query_department_id")
      )
      
      redirect_to("/courses/#{@course.id}")
    else
      redirect_to("/courses")
    end
  end

  def destroy
    the_id = params.fetch("path_id")  
    @course = Course.where({ :id => the_id}).at(0)  

    if @course.present?
      @course.destroy
      flash[:notice] = "Course deleted successfully."
    else
      flash[:alert] = "Course not found."
    end

    redirect_to("/courses")
  end
end
