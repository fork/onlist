require "#{ File.dirname __FILE__ }/../initializer.rb"

def create_item
  item = Item.create
  yield item if block_given?
ensure
  item and item.destroy
end

describe 'Item onlist' do
  Item.onlist

  before(:each) { Onlist::Entry.delete_all }

  it 'should be accepted' do
    create_item { |item| ( item.accept ).should.be.accepted }
  end

  it 'should be rejected' do
    create_item { |item| ( item.reject ).should.be.rejected }
  end

end

describe 'Item on whitelist' do
  Item.on_whitelist

  before(:each) { Onlist::Entry.delete_all }


end

describe 'Item on blacklist' do
  Item.on_blacklist

  before(:each) { Onlist::Entry.delete_all }


end

describe 'Item internally on list with defaults' do
  Item.onlist :composed_of

  before(:each) { Onlist::Entry.delete_all }


end

describe 'Item internally on list' do
  Item.onlist :composed_of => [ :published_at, :hidden_at ]

  before(:each) { Onlist::Entry.delete_all }


end

describe 'Item internally on whitelist with defaults' do
  Item.on_whitelist :composed_of

  before(:each) { Onlist::Entry.delete_all }


end

describe 'Item internally on whitelist' do
  Item.on_whitelist :composed_of => :published_at

  before(:each) { Onlist::Entry.delete_all }


end

describe 'Item internally on blacklist with defaults' do
  Item.on_blacklist :composed_of

  before(:each) { Onlist::Entry.delete_all }


end

describe 'Item internally on blacklist' do
  Item.on_blacklist :composed_of => :hidden_at

  before(:each) { Onlist::Entry.delete_all }


end

__END__
onlist :intern => true
onlist :intern => [:accepted_at, :rejected_at]
on_whitelist :intern => true
on_whitelist :intern => :accepted_at
on_blacklist :intern => true
on_blacklist :intern => :rejected_at
