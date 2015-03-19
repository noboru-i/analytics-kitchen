#
# Cookbook Name:: kibana
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user = node[:kibana][:user]
group = node[:kibana][:group] || user
version = node[:kibana][:version] || '4.0.1'
filename = "kibana-#{version}-linux-x64.tar.gz"
install_dir = "/home/#{user}/site"

remote_file "#{Chef::Config[:file_cache_path]}/#{filename}" do
  source "https://download.elasticsearch.org/kibana/kibana/#{filename}"
end

directory "#{install_dir}" do
    owner user
    group group
    action :create
end

bash 'install kibana' do
  user user
  group group
  code <<-EOC
      tar zxf #{Chef::Config[:file_cache_path]}/#{filename} -C #{install_dir}
  EOC
  not_if { File.exists?("#{install_dir}/#{filename}") }
end

link "#{install_dir}/kibana" do
  to "#{install_dir}/kibana-#{version}"
end

template "default" do
    path "/etc/nginx/sites-available/default"
    source "default.erb"
    variables({
      :user => user
    })
    owner "root"
    group "root"
    mode 0644
    notifies :reload, 'service[nginx]'
end
