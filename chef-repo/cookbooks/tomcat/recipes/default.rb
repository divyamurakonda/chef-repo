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
end

execute 'tar xzvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1'
