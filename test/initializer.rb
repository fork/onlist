require 'rubygems'
require 'activerecord'

ActiveRecord::Base.establish_connection(
 :adapter => 'sqlite3',
 :database  => ':memory:'
)

if true
  ActiveRecord::Base.logger = ActiveSupport::BufferedLogger.new(STDOUT)
  ActiveRecord::Base.colorize_logging = false
end

ActiveRecord::Base.connection.instance_eval do
  create_table :onlist do |t|
    t.references :onlisted, :null => false, :polymorphic => true
    t.boolean :accepted
    t.timestamps
  end
  create_table :items do |t|
    t.timestamps
  end
end

require 'test/spec'
class Test::Spec::Should
  def belong_to(assoc_name)
    reflection = @object.reflect_on_association assoc_name

    assert_kind_of ActiveRecord::Reflection::AssociationReflection, reflection
    assert_equal :belongs_to, reflection.macro
  end
  def have_many(assoc_name)
    reflection = @object.reflect_on_association assoc_name

    assert_kind_of ActiveRecord::Reflection::AssociationReflection, reflection
    assert_equal :has_many, reflection.macro
  end
  def have_one(assoc_name)
    reflection = @object.reflect_on_association assoc_name

    assert_kind_of ActiveRecord::Reflection::AssociationReflection, reflection
    assert_equal :has_one, reflection.macro
  end
end


$: << "#{ File.dirname __FILE__ }/../lib"
require "#{ File.dirname __FILE__ }/../init.rb"
require "#{ File.dirname __FILE__ }/../install/entry"

class Item < ActiveRecord::Base
  onlist :updates => :updated_at
end

3.times { Item.create }
