#
# Cookbook Name:: tomcat
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# execute "sudo apt-get install default-jdk"
package "default-jdk"

# execute "sudo groupadd tomcat"
# group 'tomcat'

# execute "sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat"
user 'tomcat' do
  shell '/bin/false'
  group 'tomcat'
  home '/opt/tomcat'
end

# curl -O http://apache.mirrors.ionfish.org/tomcat/tomcat-8/v8.5.5/bin/apache-tomcat-8.5.5.tar.gz
remote_file 'apache-tomcat-8.5.5.tar.gz' do
  source 'http://apache.mirrors.ionfish.org/tomcat/tomcat-8/v8.5.5/bin/apache-tomcat-8.5.5.tar.gz'
end

directory '/opt/tomcat' do
  # action :create
  group 'tomcat'
end

execute 'tar xzvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1'

# TODO: NOT DESIRED STATE
execute 'chgrp -R tomcat /opt/tomcat'

directory '/opt/tomcat/conf' do
  mode '0070'
end

# TODO: NOT DESIRED STATE
execute 'chmod -R g+r /opt/tomcat/conf'

# TODO: NOT DESIRED STATE
execute 'chmod g+x /opt/tomcat/conf'

execute 'chown -R tomcat webapps/ work/ temp/ logs/'

template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end

execute 'systemctl daemon-reload'

service 'tomcat' do
  action [:start, :enable]
end
