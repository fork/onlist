module Onlist::Extension

  # onlist :updates => :updated_at
  def onlist(opts = {})
    self.class_inheritable_reader :onlist_options
    self.inheritable_attributes[:onlist_options] = opts

    extend Onlist::ClassMethods
    include Onlist::InstanceMethods
  end

  def on_blacklist(opts = {})
    self.class_inheritable_reader :onlist_options
    self.inheritable_attributes[:onlist_options] = opts

    extend Onlist::Blacklist::ClassMethods
    include Onlist::Blacklist::InstanceMethods
  end

  def on_whitelist(opts = {})
    self.class_inheritable_reader :onlist_options
    self.inheritable_attributes[:onlist_options] = opts

    extend Onlist::Whitelist::ClassMethods
    include Onlist::Whitelist::InstanceMethods
  end

end
