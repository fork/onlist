module Onlist
  module Whitelist
    module InstanceMethods
      include ::Onlist::InstanceMethods

      def onlist
        Whitelist::Proxy.new self
      end

      alias_method :rejected?, :unlisted?

    end
  end
end
