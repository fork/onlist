module Onlist
  module Blacklist
    module InstanceMethods
      include ::Onlist::InstanceMethods

      def onlist
        Blacklist::Proxy.new self
      end

      alias_method :accepted?, :unlisted?

    end
  end
end
