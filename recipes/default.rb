#
# Cookbook Name:: numa08_net
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/usr/local/etc/numa08_net.zip" do
	mode 0644
end

bash "install numa08" do
	code <<-EOC
		rm -rf #{node.numa08.home}
		cd /usr/local/etc
		unzip -o numa08_net.zip
		mv #{node.numa08.app_dir} #{node.numa08.home}
	EOC
end

template "/etc/rc.d/init.d/numa08_net" do
	source "numa08_net.erb"
	mode 0755
	owner "root"
	group "root"
end

bash "chkconfig" do
	code <<-EOC
	chkconfig --add numa08_net
	EOC
end

service "numa08_net" do
	action [ :enable, :start]
	supports :status =>true, :restart => true, :start => true, :stop => true
end

package "nginx" do
	action :install
end

template "/etc/nginx/conf.d/default.conf" do
	source "default.conf.erb"
	mode 0644
	owner "root"
	group "root"
end

service "nginx" do
	action [:enable, :start]
end