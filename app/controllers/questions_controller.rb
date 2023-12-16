class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    set_questions
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to questions_path
    else
      set_questions
      render :index, status: :unprocessable_entity
    end
  end


  private

  def set_questions
    if current_user.grade_id == 1
      @questions = Question.includes(:user).order("created_at DESC")
    else
      @questions = Question.where(user_id: current_user.id).includes(:user).order("created_at DESC")
    end
  end

  def question_params
    params.require(:question).permit(:title).merge(user_id: current_user.id)
  end
end
