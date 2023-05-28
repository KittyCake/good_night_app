# Good Night Application API

## Description

Good Night Application API is a simple web application to track users' sleep time. It allows users to record when they go to bed and wake up. Users can also follow and unfollow other users.

## Version
- Ruby version 3.0.0
- Rails 7.0.4.3

## Installation

1. Clone the repo

2. Navigate to the project directory
```
cd good_night_app
```

3. Install all dependencies
```
bundle install
```

4. Create and initialize database
```
rake db:create
rake db:migrate
```

## Run the application
```
rails s
```

Then navigate to http://localhost:3000 in your browser.

## API Endpoints

### SleepRecordsController
- POST /sleep_records: Clock in operation
- GET /sleep_records: Get all clocked-in times, ordered by creation time.
- GET /followings_records: Get sleep records of a user's following users from the previous week, sorted based on the duration.

### FollowsController
- POST /follows: Users can follow other users.
- DELETE /follows/destroy_by_user_ids: Users can unfollow other users.

## Running Tests

```
bundle exec rspec
```