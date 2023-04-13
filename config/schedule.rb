set :output, 'log/cron.log'
set :env_path, '"$HOME/.rbenv/shims":"$HOME/.rbenv/bin"'

job_type :rails,
         ' cd :path && PATH=:env_path:"$PATH" RAILS_ENV=:environment bundle exec rails :task --silent :output '
job_type :runner, %q( cd :path && PATH=:env_path:"$PATH" bin/rails runner -e :environment ':task' :output )
job_type :script, ' cd :path && PATH=:env_path:"$PATH" RAILS_ENV=:environment bundle exec bin/:task :output '

every 1.day, at: '08:00 am' do
  runner 'MailNotificationJob.perform_async'
end
