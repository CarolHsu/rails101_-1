set :application, "forum_demo" 
set :domain, "dtest.buyble.com.tw" 
set :repository, "git@github.com:CarolHsu/rails101_-1.git" # your ssh way in github.
set :deploy_to, "/home/apps/forum_demo" 
role :app, domain
role :web, domain
role :db, domain, :primary => true
set :deploy_via, :remote_cache
set :deploy_env, "production" 
set :rails_env, "production" 
set :scm, :git
set :branch, "master" 
set :scm_verbose, true
set :use_sudo, false
set :user, "apps" 
set :group, "apps" 
default_environment["PATH"] = "/opt/ruby/bin:/opt/ruby/bin:/opt/ruby/bin:/opt/bin/ruby/bin:/opt/ruby/bin:/opt/ruby/bin:/opt/ruby/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games" 
namespace :deploy do
desc "restart" 
task :restart do
run "touch #{current_path}/tmp/restart.txt" 
end
end
desc "Create database.yml and asset packages for production" 
after("deploy:update_code") do
db_config = "/home/apps/database.yml.production" 
run "cp #{db_config} #{release_path}/config/database.yml" 
end  
