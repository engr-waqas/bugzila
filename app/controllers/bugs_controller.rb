# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :find_bug, except: %i[new index create]
  before_action :find_project, except: %i[update destroy]
  before_action :authorize_bug, only: %i[edit update destroy assign change_status]

  def index
    @bugs = @project.bugs
  end

  def edit; end

  def new
    @bug = Bug.new
  end

  def create
    @bug = current_user.bugs.new(bug_params)
    @bug.project = @project
    authorize_bug
    if @bug.save
      redirect_to project_bugs_path, notice: 'Bug Created Successfully.'
    else
      render 'new', notice: 'Bug Creation Unsuccessful.'
    end
  end

  def update
    if @bug.update(bug_params)
      redirect_to project_bugs_path, notice: 'Bug Updated Successfully.'
    else
      render 'edit', notice: 'Bug Updation Unsuccessful.'
    end
  end

  def destroy
    if @bug.destroy
      redirect_to project_bugs_path, notice: 'Bug Deleted Successfully.'
    else
      redirect_to project_bugs_path, notice: 'Bug Deletion Unsuccessful.'
    end
  end

  def assign
    @user = User.find_by(id: params[:user_id])
    if @bug.update(developer: @user, status: :started)
      redirect_to project_bugs_path(@project), notice: 'Bug Assigned Successfully.'
    else
      redirect_to project_bugs_path(@project), notice: 'Bug assign Unsuccessful'
    end
  end

  def change_status
    if @bug.update(status: :resolved)
      redirect_to project_bugs_path(@project), notice: 'Bug Status Changed.'
    else
      redirect_to project_bugs_path(@project), notice: 'Bug Status not changed.'
    end
  end

  private

  def find_bug
    @bug = Bug.find_by(id: params[:id])
  end

  def find_project
    @project = Project.find_by(id: params[:project_id])
  end

  def authorize_bug
    authorize @bug
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :bug_type, :status, :screenshot)
  end
end
