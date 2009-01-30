require "#{ File.dirname __FILE__ }/initializer.rb"

describe 'Onlist' do

  it "should belong to onlisted" do
    Onlist::Entry.should.belong_to :onlisted
  end

end
