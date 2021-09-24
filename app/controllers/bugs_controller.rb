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
    authorize @bug
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
      redirect_to project_bugs_url
    else
      render 'new'
    end
  end

  def update
    authorize @bug
    if @bug.update(bug_params)
      redirect_to project_bugs_url
    else
      render 'edit'
    end
  end

  def destroy
    authorize @bug
    @bug.destroy
    redirect_to project_bugs_url
  end

  private

  def set_bug
    @bug = Bug.find(params[:id])
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :bug_type, :status, :screenshot)
  end
end
