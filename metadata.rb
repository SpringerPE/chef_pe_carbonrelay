name             'pe_carbonrelay'
maintainer       'Jose Riguera Lopez'
maintainer_email 'jose.riguera@springer.com'
license          'Apache 2.0'
description      'Installs/Configures carbon-c-relay'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.3'

%w{ debian ubuntu centos redhat  }.each do |os|
  supports os
end
