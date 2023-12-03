class ResultsController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_root

  def index
    @student = User.find(params[:student_id])
    @results = @student.results
  end

  def show
    @student = User.find(params[:student_id])
    @result = @student.results.find(params[:id])
  end


  private

  def move_to_root
    if params[:student_id].to_i != current_user.id && current_user.grade_id != 1
      redirect_to root_path
    end
  end
end
