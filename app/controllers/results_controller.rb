class ResultsController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_root

  def index
    @student = User.find(params[:student_id])
    @results = @student.results
    @new_result = Result.new
  end

  def show
    @student = User.find(params[:student_id])
    @result = @student.results.find(params[:id])
  end

  def create
    @new_result = Result.new(result_params)
    if @new_result.save
      redirect_to student_result_path(@new_result.user_id, @new_result.id)
    else
      @student = User.find(params[:student_id])
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
end
