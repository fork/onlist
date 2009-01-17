module Onlist
  module Whitelist
    class Proxy < ::Onlist::Proxy

      def accept
        entry.destroy and
        @item.run_callbacks :when_accepted
      end

    end
  end
end
