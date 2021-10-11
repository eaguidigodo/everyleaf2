# todos

* todos_id: int

* todos_name: string(50)

* users_id: int

# users

* users_id: int

* username: string(50)

* email: string(50)

* password: string(50)

# tasks

* tasks_id: int

* todos_id: int

* tasks_name: string(50)

* deadline: date

* status: string(50)

* priority: string(50)

* label: string(50)

# NB: tasks will be todos's nested properties

#Steps for deploying on heroku:

For heroku deployment, first create an account on heroku and then run the following commands:

*heroku login

*heroku create

*rails assets:precompile RAILS_ENV=production

*heroku buildpacks:set heroku/ruby

*heroku buildpacks:add --index 1 heroku/nodejs

*git push heroku step2:main

*heroku run rails  db:migrate 

