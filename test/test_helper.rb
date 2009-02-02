$: << "#{ File.dirname __FILE__ }/../lib"

require "#{ File.dirname __FILE__ }/activerecord_setup"
require "#{ File.dirname __FILE__ }/../init.rb"
require "#{ File.dirname __FILE__ }/../install/entry"
require "#{ File.dirname __FILE__ }/spec"
require "#{ File.dirname __FILE__ }/spec/helper"
