# attributes
default[:pe_carbonrelay][:data_bag] = 'metrics'
default[:pe_carbonrelay][:bag_name] = 'relay'
default[:pe_carbonrelay][:environment] = node[:chef_environment]?node[:chef_environment]:"_default"

# package and version
default[:pe_carbonrelay][:version] = '0.36'
default[:pe_carbonrelay][:download] = "http://artifactory.tools.springer-sbm.com/simple/spr-deb-release-local/pool/carbon-c-relay_#{node[:pe_carbonrelay][:version]}_amd64.deb"
default[:pe_carbonrelay][:checksum] = "1411b3890fe9c7d009cfd787ad7cfa7ab5664311"
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
##		:rewrite => [
##			{ :in => "(.+)", :out => 'server.\\1' }
##		],
#		:match => [
#			{ :expr => "*", :to => "local", :stop => true }
#		]
#	}
} 

