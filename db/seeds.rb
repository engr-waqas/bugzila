# frozen_string_literal: true

logger = Rails.logger
logger.info('Creating Users...')
User.find_or_create_by!(email: 'abdullah@gmail.com') do |user|
  user.name = 'Abdullah'
  user.password = 'abdullah123'
  user.user_type = User.user_types[:manager]
end
User.find_or_create_by!(email: 'Ali@gmail.com') do |user|
  user.name = 'Ali'
  user.password = 'ali123'
  user.user_type = User.user_types[:manager]
end
User.find_or_create_by!(email: 'hassan@gmail.com') do |user|
  user.name = 'Hassan'
  user.password = 'hassan123'
  user.user_type = User.user_types[:developer]
end
User.find_or_create_by!(email: 'hassam@gmail.com') do |user|
  user.name = 'Hassam'
  user.password = 'hassam123'
  user.user_type = User.user_types[:developer]
end
User.find_or_create_by!(email: 'waqas@gmail.com') do |user|
  user.name = 'Waqas'
  user.password = 'waqas123'
  user.user_type = User.user_types[:qa]
end
User.find_or_create_by!(email: 'waqar@gmail.com') do |user|
  user.name = 'Waqar'
  user.password = 'waqar123'
  user.user_type = User.user_types[:qa]
end
logger.info('Users Created!')

logger.info('Creating Projects...')
User.first.projects.find_or_create_by!(title: 'Grosery Store') do |project|
  project.description = 'Buy and sell all kinds of grosery items.'
end
User.first.projects.find_or_create_by!(title: 'Shopping App') do |project|
  project.description = 'A small shopping app to buy.'
end
User.last.projects.find_or_create_by!(title: 'Doorstep Services') do |project|
  project.description = 'Physical services at Doorstep.'
end
User.last.projects.find_or_create_by!(title: 'wHealth') do |project|
  project.description = 'Appointment booking.'
end
logger.info('Projects Created!')

first_user_bugs = User.last(2).first.bugs
last_user_bugs = User.last.bugs

logger.info('Creating Bugs...')
first_user_bugs.find_or_create_by!(title: 'Mutable') do |bug|
  bug.description = 'Symbol error.'
  bug.deadline = Time.now.getlocal + 1.week
  bug.bug_type = Bug.bug_types[:bug]
  bug.status = Bug.statuses[:newly]
  bug.project_id = Project.first.id
end
first_user_bugs.find_or_create_by!(title: 'Format') do |bug|
  bug.description = 'Email format error.'
  bug.deadline = Time.now.getlocal + 1.week
  bug.bug_type = Bug.bug_types[:bug]
  bug.status = Bug.statuses[:newly]
  bug.project_id = Project.first.id
end
first_user_bugs.find_or_create_by!(title: 'Multiple connections') do |bug|
  bug.description = 'Multiple databases.'
  bug.deadline = Time.now.getlocal + 1.week
  bug.bug_type = Bug.bug_types[:bug]
  bug.status = Bug.statuses[:newly]
  bug.project_id = Project.first.id
end
last_user_bugs.find_or_create_by!(title: 'Fuction') do |bug|
  bug.description = 'Transformation.'
  bug.deadline = Time.now.getlocal + 1.week
  bug.bug_type = Bug.bug_types[:feature]
  bug.status = Bug.statuses[:newly]
  bug.project_id = Project.last.id
end
last_user_bugs.find_or_create_by!(title: 'Contacl list') do |bug|
  bug.description = 'Default list.'
  bug.deadline = Time.now.getlocal + 1.week
  bug.bug_type = Bug.bug_types[:feature]
  bug.status = Bug.statuses[:newly]
  bug.project_id = Project.last.id
end
last_user_bugs.find_or_create_by!(title: 'Overflow') do |bug|
  bug.description = 'Limit crossing.'
  bug.deadline = Time.now.getlocal + 1.week
  bug.bug_type = Bug.bug_types[:feature]
  bug.status = Bug.statuses[:newly]
  bug.project_id = Project.last.id
end
logger.info('Bugs Created!')
