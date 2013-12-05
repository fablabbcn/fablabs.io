require 'new_relic/recipes'

namespace :newrelic do
  desc "Install newrelic server monitor"
  task :install, roles: :app do
    run "#{sudo} wget -O /etc/apt/sources.list.d/newrelic.list http://download.newrelic.com/debian/newrelic.list"
    run "wget -O- https://download.newrelic.com/548C16BF.gpg | #{sudo} apt-key add -"
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install newrelic-sysmond"
    run "#{sudo} nrsysmond-config --set license_key=#{ENV['NEW_RELIC']}"
    run "#{sudo} /etc/init.d/newrelic-sysmond start"
  end
end

after "deploy", "newrelic:notice_deployment"
after "deploy:update", "newrelic:notice_deployment"
after "deploy:migrations", "newrelic:notice_deployment"
after "deploy:cold", "newrelic:notice_deployment"
