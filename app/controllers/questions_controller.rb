class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @question = Question.new
    if current_user.grade_id == 1
      @questions = Question.includes(:user).order("created_at DESC")
    else
      @questions = Question.where(user_id: current_user.id).includes(:user).order("created_at DESC")
    end
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to questions_path
    else
      if current_user.grade_id == 1
        @questions = Question.includes(:user).order("created_at DESC")
      else
        @questions = Question.where(user_id: current_user.id).includes(:user).order("created_at DESC")
      end
      render :index, status: :unprocessable_entity
    end
  end


  private

  def question_params
    params.require(:question).permit(:title).merge(user_id: current_user.id)
  end
end
