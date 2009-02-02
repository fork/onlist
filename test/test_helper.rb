require 'rubygems'
require 'activerecord'

ActiveRecord::Base.establish_connection(
 :adapter => 'sqlite3',
 :database  => ':memory:'
)

if $-v
  ActiveRecord::Base.logger = ActiveSupport::BufferedLogger.new STDOUT
  ActiveRecord::Base.colorize_logging = false
end

ActiveRecord::Base.connection.instance_eval do
  create_table :onlist do |t|
    t.references :onlisted, :null => false, :polymorphic => true
    t.timestamp :accepted_at
    t.timestamp :rejected_at
  end
  create_table :items do |t|
    t.timestamp :accepted_at
    t.timestamp :rejected_at
    t.timestamp :published_at
    t.timestamp :hidden_at
  end
end

$: << "#{ File.dirname __FILE__ }/../lib"
require "#{ File.dirname __FILE__ }/../init.rb"
require "#{ File.dirname __FILE__ }/../install/entry"

class Item < ActiveRecord::Base; end

require 'spec'
require 'spec/helper'
