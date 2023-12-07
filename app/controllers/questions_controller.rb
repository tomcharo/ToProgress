class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.grade_id == 1
      @questions = Question.includes(:user).order("created_at DESC")
    else
      @questions = Question.where(user_id: current_user.id).includes(:user).order("created_at DESC")
    end
  end
end
