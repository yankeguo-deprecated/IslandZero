namespace :deploy do
  COMMANDS = %w(start stop restart)

  COMMANDS.each do |command|
    task command do
      on roles(:app), in: :sequence, wait: 5 do
        within current_path do
          execute :bundle, "exec thin #{command} -C config/cap/thin/#{fetch(:stage)}.yml"
        end
      end
    end
  end

  # RVM integration
  if Gem::Specification::find_all_by_name('capistrano-rvm').any?
    COMMANDS.each { |c| before c, 'rvm:hook' }
  end
end
