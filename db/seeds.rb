# frozen_string_literal: true

puts('Creating Users...')
User.find_or_create_by(email: 'abdullah@gmail.com', user_type: :manager) do |user|
  user.name = 'Abdullah'
  user.password = 'abdullah123'
end
User.find_or_create_by(email: 'Ali@gmail.com', user_type: :manager) do |user|
  user.name = 'Ali'
  user.password = 'ali123'
end
User.find_or_create_by(email: 'hassan@gmail.com', user_type: :developer) do |user|
  user.name = 'Hassan'
  user.password = 'hassan123'
end
User.find_or_create_by(email: 'hassam@gmail.com', user_type: :developer) do |user|
  user.name = 'Hassam'
  user.password = 'hassam123'
end
User.find_or_create_by(email: 'waqas@gmail.com', user_type: :qa) do |user|
  user.name = 'Waqas'
  user.password = 'waqas123'
end
User.find_or_create_by(email: 'waqar@gmail.com', user_type: :qa) do |user|
  user.name = 'Waqar'
  user.password = 'waqar123'
end
puts('Users Created!')

puts('Creating Projects...')
User.first.projects.find_or_create_by(title: 'Grosery Store',
                                      description: 'Buy and sell all kinds of grosery items.')
User.first.projects.find_or_create_by(title: 'Shopping App', description: 'A small shopping app to buy.')
User.last.projects.find_or_create_by(title: 'Doorstep Services',
                                     description: 'Physical services at Doorstep.')
User.last.projects.find_or_create_by(title: 'wHealth', description: 'Appointment booking.')
puts('Projects Created!')

puts('Creating Bugs...')
User.last(2).first.bugs.find_or_create_by(title: 'Mutable', bug_type: :bug) do |bug|
  bug.description = 'Symbol error.'
  bug.deadline = Time.now.getlocal + 1.week
  bug.bug_type = Bug.bug_types.keys.first
  bug.status = Bug.statuses.keys.first
  bug.project_id = Project.first.id
end
User.last(2).first.bugs.find_or_create_by(title: 'Format', bug_type: :bug) do |bug|
  bug.description = 'Email format error.'
  bug.deadline = Time.now.getlocal + 1.week
  bug.bug_type = Bug.bug_types.keys.first
  bug.status = Bug.statuses.keys.first
  bug.project_id = Project.first.id
end
User.last(2).first.bugs.find_or_create_by(title: 'Multiple connections', bug_type: :bug) do |bug|
  bug.description = 'Multiple databases.'
  bug.deadline = Time.now.getlocal + 1.week
  bug.bug_type = Bug.bug_types.keys.first
  bug.status = Bug.statuses.keys.first
  bug.project_id = Project.first.id
end
User.last.bugs.find_or_create_by(title: 'Fuction') do |bug|
  bug.description = 'Transformation.'
  bug.deadline = Time.now.getlocal + 1.week
  bug.bug_type = Bug.bug_types.keys.last
  bug.status = Bug.statuses.keys.first
  bug.project_id = Project.last.id
end
User.last.bugs.find_or_create_by(title: 'Contacl list') do |bug|
  bug.description = 'Default list.'
  bug.deadline = Time.now.getlocal + 1.week
  bug.bug_type = Bug.bug_types.keys.last
  bug.status = Bug.statuses.keys.first
  bug.project_id = Project.last.id
end
User.last.bugs.find_or_create_by(title: 'Overflow') do |bug|
  bug.description = 'Limit crossing.'
  bug.deadline = Time.now.getlocal + 1.week
  bug.bug_type = Bug.bug_types.keys.last
  bug.status = Bug.statuses.keys.first
  bug.project_id = Project.last.id
end
puts('Bugs Created!')
