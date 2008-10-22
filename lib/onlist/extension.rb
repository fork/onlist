module Onlist::Extension

  # onlist :updates => :updated_at
  def onlist(opts)
    self.class_inheritable_reader :onlist_options
    self.inheritable_attributes[:onlist_options] = opts

    extend Onlist::ClassMethods
    include Onlist::InstanceMethods
  end

end
