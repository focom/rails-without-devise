# rails-without-devise
## Incubit challenge

To start this project I used the [Heroku boilerplate](https://github.com/heroku/ruby-getting-started)

All the required features are implemented:
- Registration
- Login/Logout
- Profile update
- Reset password with email

## Run the project
```bash
git clone https://github.com/focom/rails-without-devise.git
cd rails-without-devise
bundle install
rails db:create
rails db:migrate
rails s
```

You can now open the project in [your browser here](http://localhost:3000/)

The project run on port `3000`

## Run the tests
```bash
rails test
```
I ran out of time to improve coverage of test but I think they show my ability to write
`unittest` and `end2end test`

## Screenshots
![1](/screenshots/Screenshot%20from%202020-05-27%2002-00-27.png)
![2](/screenshots/Screenshot%20from%202020-05-27%2002-01-00.png)
![3](/screenshots/Screenshot%20from%202020-05-27%2002-01-52.png)
