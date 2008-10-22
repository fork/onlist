require "#{ File.dirname __FILE__ }/initializer.rb"

describe 'Onlist' do

  it "should belong to onlisted" do
    Onlist.should.belong_to :onlisted
  end

  it "should update foreign timestamp when saved" do
    item = Item.first

    sleep 1
    item.onlist.accept

    item.reload
    item.updated_at.should == item.oli.updated_at
  end

  it "should update foreign timestamp when destroyed" do
    item = Item.first
    item.onlist.accept
    oli = item.oli

    sleep 1
    item.oli.destroy

    item.reload
    item.updated_at.should.not == oli.updated_at
  end

end
