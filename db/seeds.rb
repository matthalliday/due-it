# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

User.create(username: 'admin',
            email: 'admin@example.com',
            password: 'secret')

Project.create(user_id: 1,
               name: 'Sample Project',
               description: 'A sample project for demo purposes',
               incomplete_tasks: 2)

Task.create(project_id: 1,
            name: 'Your first task',
            description: 'A sample task for demo purposes',
            estimate: '5 minutes',
            due_date: 30.days.from_now)

Task.create(project_id: 1,
            name: 'Your second task',
            description: 'Another sample task for demo purposes',
            estimate: '2 days',
            due_date: 4.days.from_now)
