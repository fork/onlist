require 'onlist'
require 'onlist/class_methods'
require 'onlist/extension'
require 'onlist/instance_methods'
require 'onlist/proxy'

ActiveRecord::Base.extend Onlist::Extension
