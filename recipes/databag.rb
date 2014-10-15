#
# Cookbook Name:: pe_carbonrelay
# Recipe:: databag
#
# Copyright (C) 2014 Jose Riguera, Springer SBM
# 

class ::Chef::Recipe
  include SPRpe
end

if node[:pe_carbonrelay][:bag_name]
  begin
    databag = node[:pe_carbonrelay][:data_bag]
    bagname = node[:pe_carbonrelay][:bag_name]
    environment = node[:pe_carbonrelay][:environment]
    set_databag('pe_carbonrelay', databag, bagname, environment)
  rescue
    Chef::Application.fatal!('Something was wrong while processing data_bag!', 1)
  end
end

