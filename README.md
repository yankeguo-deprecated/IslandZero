# MAGI::Systems

![Travis Status](https://travis-ci.org/yanke-guo/magi-systems.svg?branch=master)

Site    [https://magi.systems](https://magi.systems)

Github (Main Repo)  [https://github.com/yanke-guo/magi-systems](https://github.com/yanke-guo/magi-systems)

Gitcafe(Mirror Repo) [https://gitcafe.com/yanke_guo/magi-systems](https://gitcafe.com/yanke_guo/magi-systems)

## Requirements

-  Ruby (Modern)
-  Redis
-  MySQL

## Configuration

MAGI::Systems use `Figaro` for configuration.

-  Copy `config/application.yml.sample` to `config/application.yml`, then edit it.

It is suggested to move parameters to `config/application.yml`, thus `Capistrano` will handle it well.

## Run

-  Thin     (see `config/thin/production.yml`)
-  Sidekiq  (see `config/sidekiq.yml`)

## Deploy via 'Docker'

- Install `docker`
- Run  `mysql`, don't forget to specify a database with user
- Run  `redis`
- Run `yanke/magi-systems` with `mysql`, `redis` linked as the alias name exactly `mysql` and `redis`.

See config/application.yml.sample for avaliable environment variables.

See fig.yml for how to start `thin` and `sidekiq`.

## Deploy via `fig`

- Install `docker`
- Install `fig`
- Clone this repo
- Copy `config/application.yml.sample` to `config/application.yml`, then edit it.
- `fig run web bundle exec rake db:migrate`
- `fig up`

## Deploy Via `Capistrano`

-  Install `ruby`, `mysql`, `redis` in your remote server and start them.
-  Copy `config/application.yml.sample` to `config/application.yml`, then edit it, don't forget to add a server.
-  Run  `bundle exec cap deploy:setup`, prepare initial environment.
-  Run  `bundle exec cap figaro:setup`, deploy local `application.yml` to remote.
-  Run  `bundle exec cap deploy`, deploy a new release.
-  Run  `bundle exec cap deploy:restart`, restart `thin`.

## Development

From commit `f2bf2e32976f476cea466890b06096e0abdbd460` onward, all commits made by me will be signed with GPG key `YANKE Guo <me@yanke.io> 8C4D9C36` (unless I forget to), you can retrieve it from `hkp://keys.gnupg.net`.

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
