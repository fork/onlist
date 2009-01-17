module Onlist
  module InstanceMethods

    def onlist
      Onlist::Proxy.new self
    end

    def accepted?
      Onlist::Entry.exists? onlist.conditions(:accepted => true)
    end
    def rejected?
      Onlist::Entry.exists? onlist.conditions(:accepted => false)
    end
    def unlisted?
      not Onlist::Entry.exists? onlist.conditions
    end

  end
end
