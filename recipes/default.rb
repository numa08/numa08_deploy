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