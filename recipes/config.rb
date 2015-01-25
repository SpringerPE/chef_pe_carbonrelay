#
# Cookbook Name:: pe_carbonrelay
# Recipe:: config
#
# Copyright (C) 2014 Jose Riguera
# 

service "carbon-c-relay" do
      init_command "/etc/init.d/carbon-c-relay"
      supports :restart => true, :start => true, :stop => true
      action [ :disable, :stop ]
end 

config = node[:pe_carbonrelay][:daemon]
config.each_pair do |name, value|

   case node[:platform]
       when 'redhat', 'centos', 'fedora'
          dsttemplate = "/etc/sysconfig/carbon-c-relay-#{name}"
          inittemplate = "init.d/rh.erb"
       when "debian", "ubuntu"
          dsttemplate = "/etc/default/carbon-c-relay-#{name}"
          inittemplate = "init.d/debian.erb"
   end

   template dsttemplate do
       source 'default.conf.erb'
       mode 0644
       owner 'root'
       group 'root'
       backup false
       variables({
           :disable => value[:disable] ? 1 : 0,
           :pidfile => "/var/run/carbon-c-relay-#{name}.pid",
           :configfile => "/etc/carbon/carbon-c-relay-#{name}.conf",
           :port => value[:port] ? "-p #{value[:port]}" : nil,
           :interface => value[:interface] ? "-i #{value[:interface]}" : nil,
           :threads => value[:threads] ? "-w #{value[:threads]}" : nil,
           :batchsize => value[:batchsize] ? "-b #{value[:batchsize]}" : nil,
           :queuesize => value[:queuesize] ? "-q #{value[:queuesize]}" : nil,
           :hoststats => value[:hoststats] ? "-H #{value[:hoststats]}" : nil,
       })
       notifies :create, "template[carbon-c-relay-#{name}]", :immediately
   end

   template "/etc/carbon/carbon-c-relay-#{name}.conf" do
       source 'carbon/carbon-c-relay.conf.erb'
       mode 0644
       owner 'carbon'
       group 'root'
       backup false
       variables({
           :daemon => value
       })
       notifies :create, "template[carbon-c-relay-#{name}]", :immediately
   end

   template "carbon-c-relay-#{name}" do
      path "/etc/init.d/carbon-c-relay-#{name}"
      source inittemplate
      owner "root"
      group "root"
      mode "0755"
      backup false
      variables({
           :name => name
      })
      notifies :enable, "service[carbon-c-relay-#{name}]", :immediately
      notifies :start, "service[carbon-c-relay-#{name}]", :immediately
   end

   service "carbon-c-relay-#{name}" do
      init_command "/etc/init.d/carbon-c-relay-#{name}"
      supports :restart => true, :start => true, :stop => true
      action [ :enable, :start ]
   end 

end

