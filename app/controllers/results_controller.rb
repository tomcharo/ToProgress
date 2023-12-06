class ResultsController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_root
  before_action :set_student, only: [:index, :show]

  def index
    @categories = Category.where(:id => 1..3)
    @results = @student.results
    @new_result = Result.new
  end

  def show
    @result = @student.results.find(params[:id])
  end

  def create
    @new_result = Result.new(result_params)
    if @new_result.save
      redirect_to new_student_result_subject_path(@new_result.user_id, @new_result.id)
    else
      set_student
      @results = @student.results
      render :index, status: :unprocessable_entity
    end
  end


  private

  def result_params
    params.require(:result).permit(:name, :category_id).merge(user_id: params[:student_id])
  end

  def move_to_root
    if params[:student_id].to_i != current_user.id && current_user.grade_id != 1
      redirect_to root_path
    end
  end

  def set_student
    @student = User.find(params[:student_id])
  end
end
