class StudentsController < ApplicationController
  before_action :authenticate_user!

  def index
    unless current_user.grade_id == 1
      redirect_to root_path
    end
    @grades_lower = Grade.where(:id => 2..4)
    @grades_higher = Grade.where(:id => 5..7)
    @students = User.where(:grade_id => 2..7)
  end
end
