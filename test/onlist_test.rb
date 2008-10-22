require "#{ File.dirname __FILE__ }/initializer.rb"

describe 'Onlist' do

  it 'should belong to onlisted item' do
    Onlist.should.belong_to :onlisted
  end
  it 'should update timestamp of onlisted after listed or unlisted' do
  end

end
