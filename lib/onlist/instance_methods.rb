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
