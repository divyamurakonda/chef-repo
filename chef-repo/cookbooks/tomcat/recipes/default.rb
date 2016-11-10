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
