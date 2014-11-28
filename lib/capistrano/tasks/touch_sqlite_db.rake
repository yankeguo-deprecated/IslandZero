namespace :deploy do
  desc 'Touch db/development.sqlite3 and db/production.sqlite3 in shared_path'
  task :touch_sqlite_db do
    on roles(:db) do
      sh "mkdir -p #{shared_path}/db"
      sh "touch #{shared_path}/db/development.sqlite3"
      sh "touch #{shared_path}/db/production.sqlite3"
    end
  end
end

before 'deploy:symlink:shared', 'deploy:touch_sqlite_db'
