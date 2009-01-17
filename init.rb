require 'onlist/class_methods'
require 'onlist/whitelist/class_methods'
require 'onlist/blacklist/class_methods'

require 'onlist/instance_methods'
require 'onlist/whitelist/instance_methods'
require 'onlist/blacklist/instance_methods'

require 'onlist/proxy'
require 'onlist/whitelist/proxy'
require 'onlist/blacklist/proxy'

require 'onlist/extension'
ActiveRecord::Base.extend Onlist::Extension
