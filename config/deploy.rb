# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'admin-with-mongo'
set :repo_url, 'git@bitbucket.org:mystand/admin-with-mongo.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, "/srv/clients/#{fetch(:application)}/repository"

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

set :linked_files, %w(config/config.yml config/mongoid.yml config/secrets.yml config/unicorn.rb)

set :linked_dirs, %w(log public/assets public/uploads)

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :rvm_type, :system
set :rvm_ruby_version, '2.1.5'
# set :bundle_path, -> { shared_path.join('bundle') }  # this is default

namespace :deploy do

  desc 'Seed the database.'
  task :seed do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, 'db:seed'
        end
      end
    end
  end

  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  after :publishing, :seed
  after :seed, :finishing
  after :finishing, :restart
end

namespace :unicorn do
  pid_path = "#{fetch(:deploy_to)}/shared/pids"
  unicorn_pid = "#{pid_path}/unicorn.pid"

  def run_unicorn
    within current_path do
      execute :bundle, 'exec unicorn', "-c #{release_path}/config/unicorn.rb -D -E #{fetch(:stage)}"
    end
  end

  desc 'Start unicorn'
  task :start do
    on roles(:app) do
      run_unicorn
    end
  end

  desc 'Stop unicorn'
  task :stop do
    on roles(:app) do
      if test "[ -f #{unicorn_pid} ]"
        execute :kill, "-QUIT `cat #{unicorn_pid}`"
      end
    end
  end

  desc 'Force stop unicorn (kill -9)'
  task :force_stop do
    on roles(:app) do
      if test "[ -f #{unicorn_pid} ]"
        execute :kill, "-9 `cat #{unicorn_pid}`"
        execute :rm, unicorn_pid
      end
    end
  end

  desc 'Restart unicorn'
  task :restart do
    on roles(:app) do
      if test "[ -f #{unicorn_pid} ]"
        execute :kill, "-USR2 `cat #{unicorn_pid}`"
      else
        run_unicorn
      end
    end
  end
end
