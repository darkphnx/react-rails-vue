# VueRailsTodo

A happy-go-lucky todo list application with support for tags and comments.

Backend written in (Ruby on Rails)[https://rubyonrails.org/], frontend written in (Vue.js)[https://vuejs.org/], Styles by (spectre.css)[https://picturepan2.github.io/spectre/].

## Installation

Clone the repo, run bundler and yarn, seed the database. Default database configuration is set to sqlite, so no need to configure anything unless you want to use another backend.

```sh
git clone git@github.com:darkphnx/react-rails-vue.git
cd react-rails-vue
bundle install
yarn install
rake db:schema:load
```

## Usage

To use the app just run up a rails server

```sh
rails server
```

Then open your browser to (http://localhost:3000)[http://localhost:3000].

## Features

Tasks can be assigned tags, the list of tasks can then be filtered by clicking on tags at the top of the list.

Multiple comments can be added to tasks, this allows you to keep track of important information about your task and any progress you've made towards completing it. Comments support markdown for a rich text experience.

**Bonus whimsy** Type ![fact] in any comment to receive a fun fact about space!

## Tests

If you'd like to run the test suite simply run:

```sh
bundle exec rspec
```
