#
# Cookbook Name:: quirkafleeg-deployment
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

deploy_root = node['deployment']['root']

directory deploy_root do
  action :create
end

node['apps'].each_pair do |github_name, deploy_name|
  root_dir = "%s/%s" % [
      deploy_root,
      deploy_name
  ]

  [
      "shared",
      "shared/config",
      "shared/pids",
      "shared/log",
      "shared/system"
  ].each do |d|
    directory "%s/%s" % [
        root_dir,
        d
    ] do
      owner node['user']
      group node['user']
      action :create
      mode "0775"
      recursive true
    end
  end

  deploy_revision root_dir do
    user node['user']
    group node['user']

    environment "RACK_ENV"         => node['deployment']['rack_env'],
                "HOME"             => "/home/#{user}",
                "GOVUK_APP_DOMAIN" => "quirkafleeg.theodi.org"

    keep_releases 10
    rollback_on_error true
#    migrate true

    revision node['deployment']['revision']

    repo "git://github.com/theodi/%s.git" % [
        github_name
    ]

    before_migrate do
      current_release_directory = release_path
      running_deploy_user       = new_resource.user
      bundler_depot             = new_resource.shared_path + '/bundle'

      script 'Bundling' do
        interpreter 'bash'
        cwd current_release_directory
        user running_deploy_user
        code <<-EOF
        bundle install \
          --without=development \
          --quiet \
          --path #{bundler_depot}
        EOF
      end

      script 'Symlink env' do
        interpreter 'bash'
        cwd current_release_directory
        user running_deploy_user
        code <<-EOF
        ln -sf /home/#{user}/env .env
        EOF
      end


#      script 'Precompiling assets' do
#        interpreter 'bash'
#        cwd current_release_directory
#        user running_deploy_user
#        code <<-EOF
#        GOVUK_APP_DOMAIN=quirkafleeg.theodi.org RAILS_ENV=#{node['deployment']['rack_env']} bundle exec rake assets:precompile
#        EOF
#      end
    end

    before_restart do
      current_release_directory = release_path
      running_deploy_user       = new_resource.user

      script 'Start Me Up' do
        interpreter 'bash'
        cwd current_release_directory
        user running_deploy_user
        code <<-EOF
        export rvmsudo_secure_path=1
        /home/#{user}/.rvm/bin/rvmsudo bundle exec foreman export \
          -a #{deploy_name} \
          -u #{user} \
          -l /var/log/#{user}/#{deploy_name} \
          -p 3000 \
          upstart /etc/init
        EOF
      end
    end
    action :force_deploy
  end
end