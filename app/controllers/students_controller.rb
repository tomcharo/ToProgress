class StudentsController < ApplicationController
  before_action :authenticate_user!

  def index
    unless current_user.grade_id == 1
      redirect_to root_path
    end
    @grades = Grade.where(:id => 2..7)
  end
end
