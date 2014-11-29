# MAGI::Systems

![Travis Status](https://travis-ci.org/yanke-guo/magi-systems.svg?branch=master)

## Requirements

-  Ruby (Modern)
-  Redis
-  Sqlite3

## Configuration

MAGI::Systems use `Figaro` for configuration.

-  Copy `config/application.yml.sample` to `config/application.yml`, then edit it.
-  Check and edit `config/database.yml`, default is `sqlite3` for both `development` and `production`, ;).

It is suggested to move parameters to `config/application.yml`, thus `Capistrano` will handle it well.

## Run

-  Thin     (see `config/thin/production.yml`)
-  Sidekiq  (see `config/sidekiq.yml`)

## Deploy Via `Capistrano`

-  Setup your server with `Ruby`, and a running `Redis`.
-  Edit `config/deploy.rb`, use a proper path.
-  Edit `config/application.yml`, add a proper server.
-  Run  `bundle exec cap deploy:setup`, prepare initial environment.
-  Run  `bundle exec cap figaro:setup`, deploy local `application.yml` to remote.
-  Run  `bundle exec cap deploy`, deploy a new release.
-  Run  `bundle exec cap deploy:restart`, restart `thin`.

## Development

**ANY** stable code will be merged into master as soon as possible.
**ANY** commits made to `master` branch will deployed to `https://magi.systems` via `Travis CI`.

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
