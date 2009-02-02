require "#{ File.dirname __FILE__ }/test_helper.rb"

class Item < ActiveRecord::Base; end

module Factory
  def create_items(n)
    items = Array.new(n) { |i| Item.create }
    yield(*items) if block_given?
  ensure
    items and items.each(&:destroy)
  end
  def create_item(&block)
    create_items 1, &block
  end
end
Test::Unit::TestCase.class_eval { include Factory }

def describe_scopes(context)
  context.it 'should scope n unlisted items' do
    n = 2

    create_items(n) { |*items|
      Item.unlisted.count.should.be n
      items.each(&:accept)
      Item.unlisted.all.should.be.empty
    }
  end
  context.it 'should scope n accepted items' do
    n = 3

    create_items(n) { |*items|
      Item.accepted.count.should.be.zero
      items.first.accept and items.last.reject
      Item.accepted.should.be items.first(1)
    }
  end
  context.it 'should scope n rejected items' do
    n = 3

    create_items(n) { |*items|
      Item.rejected.count.should.be.zero
      items.first.accept and items.last.reject
      Item.rejected.should.be items.first(1)
    }
  end
  context.it 'should scope n not rejected items' do
    n = 3

    create_items(n) { |*items|
      Item.not_rejected.count.should.be n

      items.first.accept and items.last.reject
      not_rejected_items = items.first n - 1

      Item.not_rejected.sort_by { |i| i.id }.should.be not_rejected_items
    }
  end
  context.it 'should scope n not accepted items' do
    n = 3

    create_items(n) { |*items|
      Item.not_accepted.count.should.be n

      items.first.accept and items.last.reject
      not_accepted_items = items.last n - 1

      Item.not_accepted.sort_by { |i| i.id }.should.be not_accepted_items
    }
  end
end
def describe_instance_behaviour(context)
  context.it 'should be unlisted, but neither accepted not rejected' do
    create_item { |item|
      item.should.be.unlisted
      item.should.not.be.accepted
      item.should.not.be.rejected
    }
  end
  context.it 'should be accepted and not unlisted anymore' do
    create_item { |item|
      item.accept # accept_at Time.now

      item.should.be.accepted
      item.should.not.be.unlisted
    }
  end
  context.it 'should be rejected and not unlisted anymore' do
    create_item { |item|
      item.reject # reject_at Time.now

      item.should.be.rejected
      item.should.not.be.unlisted
    }
  end
end

describe 'Item scopes when associated' do
  Item.onlist
  describe_scopes self
end

describe 'Item associates onlist' do
  Item.onlist
  it('should be associated') { Item.should.have_one :onlist }
  describe_instance_behaviour self
end

describe 'Item associates onlist as whitelist' do
  Item.on_whitelist

  it 'should treat unlisted as rejected items' do
    Item.scopes[:rejected].should.be Item.scopes[:unlisted]
    Item.instance_method(:rejected?).
        should.be Item.instance_method(:unlisted?)
  end

  it 'should destroy onlist entry when rejected' do
    create_item { |item| ( item.accept and item.reject ).should.be.unlisted }
  end

end

describe 'Item associates onlist as blacklist' do
  Item.on_blacklist

  it 'should treat unlisted as accepted items' do
    Item.scopes[:accepted].should.be Item.scopes[:unlisted]
    Item.instance_method(:accepted?).
        should.be Item.instance_method(:unlisted?)
  end

  it 'should destroy onlist entry when rejected' do
    create_item { |item| ( item.reject and item.accept ).should.be.unlisted }
  end

end

describe 'Item scopes when aggregated' do
  Item.onlist :composed_of
  describe_scopes self
end

describe 'Item aggregates default onlist' do
  Item.onlist :composed_of
  it('should be aggregated') { Item.should.be_composed_of :onlist }
  describe_instance_behaviour self
end

describe 'Item aggregates customized onlist' do
  Item.onlist :composed_of => [ :published_at, :hidden_at ]


end

describe 'Item aggregates default onlist as whitelist' do
  Item.on_whitelist :composed_of


end

describe 'Item aggregates customized onlist as whitelist' do
  Item.on_whitelist :composed_of => :published_at


end

describe 'Item aggregates default onlist as blacklist' do
  Item.on_blacklist :composed_of


end

describe 'Item aggregates customized onlist as blacklist' do
  Item.on_blacklist :composed_of => :hidden_at


end

describe 'Item callbacks' do
  Item.class_eval do
    onlist

    def have_called_when_accepted; false end
    def have_called_when_rejected; false end

    def called_when_accepted
      (class << self; self; end).
      module_eval %q{ def have_called_when_accepted; true end }
    end
    when_accepted :called_when_accepted
    def called_when_rejected
      (class << self; self; end).
      module_eval %q{ def have_called_when_rejected; true end }
    end
    when_rejected :called_when_rejected

  end

  it 'should callback when_accepted' do
    create_item { |item| item.accept.should.have_called_when_accepted }
  end

  it 'should callback when_rejected' do
    create_item { |item| item.reject.should.have_called_when_rejected }
  end

end
