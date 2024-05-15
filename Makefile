install:
	bundle install

yarn_install:
	yarn install

lint_rubocop:
	rubocop

lint_slim:
	slim-lint

test:
	bin/rails test

drop_db:
	DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop

db_migrate:
	bundle exec rails db:create db:migrate

db_seed:
	bundle exec rails db:seed

compile_assets:
	bundle exec rails assets:precompile

clear_assets:
	bundle exec rails assets:clean

make_env_file:
	@if [ ! -f .env ]; then \
		cp .env.example .env; \
	fi
