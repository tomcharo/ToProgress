class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    set_question_messages
    if params[:closed] == "true"
      @question.closed = true
      @question.save
    elsif params[:closed] == "false"
      @question.closed = false
      @question.save
    end
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to question_messages_path(params[:question_id])
    else
      set_question_messages
      render :index, status: :unprocessable_entity
    end
  end


  private

  def set_question_messages
    @question = Question.find(params[:question_id])
    if @question.user_id != current_user.id && current_user.grade_id != 1
      redirect_to root_path
    end
    @messages = @question.messages.includes(:user)
  end

  def message_params
    params.require(:message).permit(:text, :image).merge(user_id: current_user.id, question_id: params[:question_id])
  end
end
