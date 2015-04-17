# IslandZero

Github (Main Repo)  [https://github.com/IslandZero/IslandZero](https://github.com/IslandZero/IslandZero)

Gitcafe(Mirror Repo) [https://gitcafe.com/yanke_guo/IslandZero](https://gitcafe.com/yanke_guo/IslandZero)

## Requirements

- Docker
- Docker Compose

## Configuration

- Copy `config.sample.env` to `config.env` and edit it.

## Deploy via `Docker`, build by yourself

- Create `/data/mysql`, `/data/redis`, `/data/uploads` for persistence.
- Pull this repo to a folder.
- Copy `docker-compose.sample.self_build.yml` to `docker-compose.yml` then edit it with `MySQL` user and password.
- Copy `config.sample.env` to `config.env` and edit it.
- `docker-compose up -d` to start, wait a bit more time after command finished.
- For newly installed only:
  - `docker-compose run web rake db:drop` drop the auto-created database due to known issue, see below.
  - `docker-compose run web rake db:create` create an new database.
- `docker-compose run web rake db:migrate` to migrate db to latest schema.
- Setup `nginx` to proxy 3000 to 80.

## Deploy via `Docker`, from image

- Create `/data/mysql`, `/data/redis`, `/data/uploads` for persistence.
- Download `docker-compose.sample.from_repo.yml` to `docker-compose.yml` then edit it with `MySQL` user, password.
- Download `config.sample.env` to `config.env` and edit it.
- `docker-compose up -d` to start, wait a bit more time after command finished.
- For newly installed only:
  - `docker-compose run web rake db:drop` drop the auto-created database due to known issue, see below.
  - `docker-compose run web rake db:create` create an new database.
- `docker-compose run web rake db:migrate` to migrate db to latest schema.
- Setup `nginx` to proxy 3000 to 80.

## Known issues

### MySQL Docker image charset problem

Official MySQL image will automatically create a database without utf8 support.

To solve this issue, drop the auto-created database and recreate with rake.

## Development

Feel free to fork or open issues.

## LICENSE

The MIT License (MIT)

Copyright (c) 2014 YANKE Guo <me@yanke.io>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

# Third Party

[Bootstrap Markdown](http://toopay.github.io/bootstrap-markdown/)
