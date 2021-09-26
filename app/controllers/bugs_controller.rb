# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :set_bug, only: %i[show edit update destroy]

  def index
    @bugs = policy_scope(Bug)
    @project = Project.find(params[:project_id])
    @bugs = @bugs.where(project: @project)
    authorize Bug
  end

  def show
    authorize set_bug
  end

  def new
    @project = Project.find(params[:project_id])
    @bug = Bug.new(project: @project)
    authorize @bug
  end

  def edit
    @project = Project.find(params[:project_id])
    authorize @bug
  end

  def create
    @bug = current_user.bugs.new(bug_params)
    @project = Project.find(params[:project_id])
    @bug.project = @project
    authorize @bug

    if @bug.save
      redirect_to project_bugs_path
    else
      render 'new'
    end
  end

  def update
    authorize set_bug
    if set_bug.update(bug_params)
      redirect_to project_bugs_path
    else
      render 'edit'
    end
  end

  def destroy
    authorize set_bug
    set_bug.destroy
    redirect_to project_bugs_path
  end

  def assign
    @project = Project.find(params[:project_id])
    @user = User.find(params[:user_id])
    authorize set_bug

    if set_bug.update(developer_id: @user.id, status: 'Started')
      redirect_to project_bugs_path(@project)
    else
      redirect_to project_bugs_path(@project), notice: 'Not success'
    end
  end

  def change_status
    @project = Project.find(params[:project_id])
    authorize set_bug
    if set_bug.update(status: 'Resolved')
      redirect_to project_bugs_path(@project)
    else
      redirect_to project_bugs_path(@project), notice: 'Not Success'
    end
  end

  private

  def set_bug
    @bug = Bug.find(params[:id])
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :bug_type, :status, :screenshot)
  end
end
