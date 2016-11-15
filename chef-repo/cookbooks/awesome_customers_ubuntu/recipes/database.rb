#
# Cookbook Name:: awesome_customers_ubuntu
# Recipe:: database
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
# Configure the MySQL client.
mysql_client 'default' do
  action :create
end

# Configure the MySQL service.
mysql_service 'default' do
  initial_root_password node['awesome_customers_ubuntu']['database']['root_password']
  action [:create, :start]
end