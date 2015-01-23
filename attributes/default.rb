# attributes
default[:pe_carbonrelay][:data_bag] = 'metrics'
default[:pe_carbonrelay][:bag_name] = 'relay'
default[:pe_carbonrelay][:environment] = node[:chef_environment]?node[:chef_environment]:"_default"

# package and version
default[:pe_carbonrelay][:version] = '0.37'
default[:pe_carbonrelay][:download] = "https://github.com/jriguera/carbon-c-relay_packages/releases/download/0.37/carbon-c-relay-#{node[:pe_carbonrelay][:version]}-1.el6.x86_64.rpm"
default[:pe_carbonrelay][:checksum] = "8fe72b38b02f4b80bc31c77b172c38f07215aeb92952296dbbc7e87234f6ac55" 
default[:pe_carbonrelay][:package] = "carbon-c-relay"

# Daemons configuration
default[:pe_carbonrelay][:daemon] = {
#	"default" => {
##		:disable => false,
#		:interface => "0.0.0.0",
#		:port => 2003,
##		:threads => 16,
##		:batchsize => 2500,
##		:queuesize => 25000,
##		:hoststats => "default",
#		:cluster => {
#			"local" => {
#				:mode => "forward",
#				:nodes => [
#					{ :host => "127.0.0.1", :port => 2013, :proto => "tcp" },
#				]
#			}
#		},
#               :rules => [
##                      { :type => "rewrite", :in => "(.+)", :out => 'server.\\1' },
#                       { :type => "match", :expr => "*", :to => "local", :stop => true } 
#               ]
#	}
} 

