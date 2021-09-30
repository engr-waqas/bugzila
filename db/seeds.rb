# frozen_string_literal: true

User.create(name: 'Abdullah', email: 'abdullah@gmail.com', password: 'abdullah123', user_type: :manager)
User.create(name: 'Ali', email: 'Ali@gmail.com', password: 'aaaaaa', user_type: :manager)
User.create(name: 'Hassan', email: 'hassan@gmail.com', password: 'hassan123', user_type: :developer)
User.create(name: 'Hassam', email: 'hassam@gmail.com', password: 'aaaaaa', user_type: :developer)
User.create(name: 'Waqas', email: 'waqas@gmail.com', password: 'waqas123', user_type: :qa)
User.create(name: 'Waqar', email: 'waqar@gmail.com', password: 'aaaaaa', user_type: :qa)

User.first.projects.create(title: 'Grosery Store', description: 'Buy and sell all kinds of grosery items.')
User.first.projects.create(title: 'Shopping App', description: 'A small shopping app to buy.')
User.find(2).projects.create(title: 'Doorstep Services', description: 'Physical services at Doorstep.')
User.find(2).projects.create(title: 'wHealth', description: 'Appointment booking.')

User.find(5).bugs.create(title: 'Mutable', description: 'Symbol error.', deadline: '2022-09-29 13:01:54',
                         bug_type: :bug, status: :newly, project_id: 1)
User.find(5).bugs.create(title: 'Format', description: 'Email format error.', deadline: '2022-09-29 13:01:54',
                         bug_type: :feature, status: :started, project_id: 1, developer_id: 3)
User.find(5).bugs.create(title: 'Multiple connections', description: 'Multiple databases.',
                         deadline: '2022-09-29 13:01:54', bug_type: :bug, status: :resolved, project_id: 2,
                         developer_id: 3)
User.last.bugs.create(title: 'Fuction', description: 'Transformation.', deadline: '2022-09-29 13:01:54',
                      bug_type: :bug, status: :newly, project_id: 2)
User.last.bugs.create(title: 'Contacl list', description: 'Default list.', deadline: '2022-09-29 13:01:54',
                      bug_type: :feature, status: :started, project_id: 3, developer_id: 4)
User.last.bugs.create(title: 'Overflow', description: 'Limit crossing.', deadline: '2022-09-29 13:01:54',
                      bug_type: :bug, status: :resolved, project_id: 4, developer_id: 4)
