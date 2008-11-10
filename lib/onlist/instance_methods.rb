module Onlist::InstanceMethods

  def onlist
    Onlist::Proxy.new self
  end

  def accepted?
    Onlist.exists? onlist.conditions(:accepted => true)
  end
  def rejected?
    Onlist.exists? onlist.conditions(:accepted => false)
  end
  def unlisted?
    onlist.entry.new_record?
  end

end

module Onlist::Blacklist::InstanceMethods
  include Onlist::InstanceMethods

  def onlist
    Onlist::Blacklist::Proxy.new self
  end

  alias_method :accepted?, :unlisted?

end

module Onlist::Whitelist::InstanceMethods
  include Onlist::InstanceMethods

  def onlist
    Onlist::Whitelist::Proxy.new self
  end

  alias_method :rejected?, :unlisted?

end
