class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_root

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to student_result_path(params[:student_id], @comment.result_id)
    else
      @student = User.find(params[:student_id])
      @result = @student.results.find(params[:result_id])
      @comments = @result.comments.includes(:user)
      render "results/show", status: :unprocessable_entity
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, result_id: params[:result_id])
  end

  def move_to_root
    if params[:student_id].to_i != current_user.id && current_user.grade_id != 1
      redirect_to root_path
    end
  end
end
