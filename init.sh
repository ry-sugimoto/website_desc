cp ./web/.env.sample ./web/.env
docker compose build
docker compose run --rm web rails db:create
docker compose run --rm web rails db:migrate
