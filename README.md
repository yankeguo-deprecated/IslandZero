# MAGI::Systems

![Travis Status](//travis-ci.org/yanke-guo/magi-systems.svg?branch=master)
![Gratipay](//img.shields.io/gratipay/yanke-guo.svg)

## Requirements

-  Ruby (Modern)
-  Redis
-  Sqlite3

## Configuration

MAGI::Systems use `Figaro` for configuration.

-  Copy `config/application.yml.sample` to `config/application.yml`, then edit it.
-  Check and edit `config/database.yml`, default is `sqlite3` for both `development` and `production`, ;).
-  If you plan to use `Capistrano`, check and edit `config/deploy.rb`, `config/deploy/*.rb`, default production server is the `https://magi.systems`, ;).

It is suggested to move any customized parameters to `config/application.yml`, thus `Capistrano` will handle it well.

## Run

-  Thin     (see `config/thin/production.yml`)
-  Sidekiq  (see `config/sidekiq.yml`)

## Development

**ANY** stable code will be merged into master as soon as possible.

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
