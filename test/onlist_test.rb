require 'rubygems'
require 'activerecord'

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
end


$: << "#{ File.dirname __FILE__ }/../lib"
require "#{ File.dirname __FILE__ }/../init.rb"

describe 'Onlist' do

  it 'should belong to onlisted item' do
    Onlist.should.belong_to :onlisted
  end
  it 'should update timestamp of onlisted after listed or unlisted' do
  end

end
