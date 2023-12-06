class SubjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_root
  before_action :set_student_result, only: [:new, :edit]

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save && params[:commit] == "保存して続ける"
      redirect_to new_student_result_subject_path(@subject.result.user_id, @subject.result_id)
    elsif @subject.save
      redirect_to student_result_path(@subject.result.user_id, @subject.result_id)
    else
      set_student_result
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @subject = @result.subjects.find(params[:id])
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update(subject_params) && params[:commit] == "保存して続ける"
      redirect_to new_student_result_subject_path(@subject.result.user_id, @subject.result_id)
    elsif @subject.update(subject_params)
      redirect_to student_result_path(@subject.result.user_id, @subject.result_id)
    else
      set_student_result
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    subject = Subject.find(params[:id])
    subject.destroy
    redirect_to new_student_result_subject_path(params[:student_id], params[:result_id])
  end


  private

  def subject_params
    params.require(:subject).permit(:name, :score, :max_score, :average_score, :rank, :rank_range).merge(result_id: params[:result_id])
  end

  def move_to_root
    if params[:student_id].to_i != current_user.id && current_user.grade_id != 1
      redirect_to root_path
    end
  end

  def set_student_result
    @student = User.find(params[:student_id])
    @result = @student.results.find(params[:result_id])
  end
end
