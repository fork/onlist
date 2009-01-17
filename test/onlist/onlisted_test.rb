require "#{ File.dirname __FILE__ }/../initializer.rb"

describe 'Extended Item' do

  before(:each) { Onlist::Entry.delete_all }

  it "should have an oli" do
    Item.should.have_one :oli
  end

  it "should have unlisted records" do
    Item.unlisted.count.should.be(3)
  end
  it "shouldn't have accepted records" do
    Item.accepted.should.be.empty
  end
  it "shouldn't have rejected records" do
    Item.rejected.should.be.empty
  end

  it "should run callback when accepted" do
    accepted = false
    Item.when_accepted { |r| accepted = true }
    Item.first.onlist.accept
    accepted.should.be(true)
  end
  it "should run callback when rejected" do
    rejected = false
    Item.when_rejected { |r| rejected = true }
    Item.first.onlist.reject
    rejected.should.be(true)
  end

end
