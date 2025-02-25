class DepartmentsController < ApplicationController
  def index
    @departments = Department.all.order(created_at: :desc)
    render({ template: "departments/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @department = Department.where(id: the_id).first  

    if @department.nil?
      flash[:alert] = "Department not found."
      redirect_to("/departments") and return
    end

    render({ template: "departments/show" })
  end

  def create
    @department = Department.new
    @department.name = params.fetch("query_name")

    if @department.save
      flash[:notice] = "Department created successfully."
    else
      flash[:alert] = "Department failed to create successfully."
    end
    redirect_to("/departments")
  end

  def update
    the_id = params.fetch("path_id")
    @department = Department.where(id: the_id).first  

    if @department.nil?
      flash[:alert] = "Department not found."
      redirect_to("/departments") and return
    end

    @department.name = params.fetch("query_name")

    if @department.save
      flash[:notice] = "Department updated successfully."
      redirect_to("/departments/#{@department.id}")
    else
      flash[:alert] = "Department failed to update successfully."
      redirect_to("/departments")
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @department = Department.where(id: the_id).first

    if @department.nil?
      flash[:alert] = "Department not found."
    else
      @department.destroy
      flash[:notice] = "Department deleted successfully."
    end

    redirect_to("/departments")
  end
end
