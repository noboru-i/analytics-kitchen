#
# Cookbook Name:: elasticsearch
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

version = node[:elasticsearch][:version] || '1.4.2'
filename = "elasticsearch-#{version}.deb"

remote_file "#{Chef::Config[:file_cache_path]}/#{filename}" do
  source "https://download.elasticsearch.org/elasticsearch/elasticsearch/#{filename}"
end

dpkg_package "#{Chef::Config[:file_cache_path]}/#{filename}" do
  action :install
end

service "elasticsearch" do
    supports :status => true, :restart => true, :reload => true
    action [ :enable, :start ]
end
