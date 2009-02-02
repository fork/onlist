require "#{ File.dirname __FILE__ }/test_helper.rb"

describe 'Onlist Entry' do

  it "should belong to listed" do
    Onlist::Entry.should.belong_to :listed
  end

end
