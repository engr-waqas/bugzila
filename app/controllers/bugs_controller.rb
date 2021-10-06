# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :find_bug, except: %i[new index create]
  before_action :find_project, except: %i[update destroy]
  before_action :find_user, only: %i[assign]
  before_action :authorize_bug

  def index
    @bugs = @project.bugs
  end

  def new
    @bug = Bug.new
  end

  def create
    @bug = current_user.bugs.new(bug_params)
    if @bug.save
      redirect_to project_bugs_path, notice: 'Bug Created Successfully!'
    else
      render 'new', notice: 'Bug Creation Unsuccessful!'
    end
  end

  def show; end

  def update
    byebug
    if @bug.update(bug_params)
      redirect_to project_bugs_path, notice: 'Bug Updated Successfully!'
    else
      render 'edit', notice: 'Bug Updation Unsuccessful!'
    end
  end

  def destroy
    if @bug.destroy
      respond_to do |format|
        redirect_to project_bugs_path, notice: 'Bug Deleted Successfully!'
        format.js
      end
    else
      redirect_to project_bugs_path, notice: 'Bug Deletion Unsuccessful!'
    end
  end

  def assign
    flash[:notice] = if @bug.update(developer: @user, status: Bug.statuses[:started])
                       'User assigned successfully!'
                     else
                       "User can't assign Bug!"
                     end
  end

  def change_status
    flash[:notice] = if @bug.update(status: Bug.statuses[:resolved])
                       'Status changed successfully!'
                     else
                       "Status can't be changed!"
                     end
  end

  private

  def find_bug
    @bug = Bug.find_by(id: params[:id])
    redirect_to project_bugs_path, notice: 'Bug not found!' if @bug.nil?
  end

  def find_project
    @project = Project.find_by(id: params[:project_id])
    redirect_to project_bugs_path, notice: 'Project not found!' if @project.nil?
  end

  def find_user
    @user = User.find_by(id: params[:user_id])
    redirect_to project_bugs_path, notice: 'User not found!' if @user.nil?
  end

  def authorize_bug
    if @bug.present?
      authorize @bug
    else
      authorize Bug
    end
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :bug_type, :status, :screenshot).tap do |bug|
      bug[:project] = @project if @project.present?
    end
  end
end
