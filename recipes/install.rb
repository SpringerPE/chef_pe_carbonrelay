#
# Cookbook Name:: pe_carbonrelay
# Recipe:: install
#
# Copyright (C) 2014 Jose Riguera
# 

if node[:pe_carbonrelay][:download]

   remote_file "/var/tmp/carbon-c-relay.package" do
      source node[:pe_carbonrelay][:download]
      checksum node[:pe_carbonrelay][:checksum]
      action :create
      notifies :install, "package[openssl]", :immediately
   end

   package "openssl" do
      action :upgrade
      notifies :install, "package[#{node[:pe_carbonrelay][:package]}]", :immediately
     case node[:platform]
     when "ubuntu","debian"
        provider Chef::Provider::Package::Apt
     when "centos", "rh"
        provider Chef::Provider::Package::Yum
     end
   end

   package node[:pe_carbonrelay][:package] do
     action :install
     source "/var/tmp/carbon-c-relay.package"
     version node[:pe_carbonrelay][:version]
     case node[:platform]
     when "ubuntu","debian"
        provider Chef::Provider::Package::Dpkg
     when "centos", "rh"
        provider Chef::Provider::Package::Rpm
     end
   end

else
   package node[:pe_carbonrelay][:package]
end

