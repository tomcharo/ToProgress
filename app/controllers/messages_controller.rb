class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @question = Question.find(params[:question_id])
    @messages = @question.messages.includes(:user)
  end
end
