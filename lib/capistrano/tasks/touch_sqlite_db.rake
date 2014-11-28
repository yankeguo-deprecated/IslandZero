namespace :deploy do
  desc 'Touch db/development.sqlite3 and db/production.sqlite3 in shared_path'
  task :touch_sqlite_db do
    on roles(:db) do
      execute "mkdir -p #{shared_path}/db"
      execute "touch #{shared_path}/db/development.sqlite3"
      execute "touch #{shared_path}/db/production.sqlite3"
    end
  end
end

before 'deploy:symlink:shared', 'deploy:touch_sqlite_db'
