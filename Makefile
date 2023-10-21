db:
	bundle exec rails db:drop
	bundle exec rails db:create
	RAILS_ENV=test bundle exec rails db:migrate
	RAILS_ENV=development bundle exec rails db:migrate

jobs:
	lsof | grep ruby

aux:
	ps aux | grep ruby

rspec: 
	RAILS_ENV=test bundle exec rspec $(F)

routes: 
	bundle exec rails routes

migrate:
	RAILS_ENV=test bundle exec rails db:migrate
	RAILS_ENV=development bundle exec rails db:migrate

rollback:
	RAILS_ENV=test bundle exec rails db:rollback
	RAILS_ENV=development bundle exec rails db:rollback

seed:
	RAILS_ENV=development bundle exec rails db:seed

console:
	RAILS_ENV=development bundle exec rails console

server:
	RAILS_ENV=development bundle exec rails server

sidek:
	RAILS_ENV=development bundle exec sidekiq

rubocop-all:
	git diff --name-only | xargs bundle exec rubocop -A

best-practices:
	bundle exec rails_best_practices

rubocop:
	bundle exec rubocop -A $(F)
