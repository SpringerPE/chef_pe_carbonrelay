# pe_carbonrelay cookbook

Cookbook to setup graphite carbon relay proxies in a flexible way. 
It supports all carbon-c-relay parameters and it can read all of them from a databag.

For more informacion go: https://github.com/jriguera/carbon-c-relay

## Supported Platforms

 * Debian
 * Ubuntu
 * Centos
 * RedHat

Note: at this moment, there is no available package for RH/Centos platforms, but the
cookbook supports them.

## Attributes

To can define the attributes, or use a databag to read and setup all of them.
For instance, here you see the attribute file of this cookbook:

```
# Main attributes
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
```
The structure of the carbon-c-relay configuration is almost its own configuration. It will create
init.d files and configuration to launch each _daemon_. 

## Usage

The easy way is just use a databag to define the way to forward the metrics
```json
{
	"id": "relay",
        "_default": {
		"daemon": {
			"default": {
				"disable": false,
				"interface": "0.0.0.0",
				"port": 2003,
				"cluster": {
					"local": {
						"mode": "forward",
						"nodes": [
							{"host": "127.0.0.1", "port": 2013, "proto": "udp"}
						]
					}
				},
				"rewrite": [
					{"in": "(.+)", "out": "servers.\\1"}
				],
				"match": [
					{ "expr": "*", "to": "local", "stop": false}
				]
			}
		}
	}
}
```

To apply the cookbook just include `pe_carbonrelay` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[pe_carbonrelay::default]"
  ]
}
```

# Author

Author:: Jose Riguera (Springer SBM) (<jose.riguera@springer.com>)
