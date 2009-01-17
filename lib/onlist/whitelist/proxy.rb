module Onlist
  module Whitelist
    class Proxy < ::Onlist::Proxy

      def reject
        entry.destroy and
        @item.run_callbacks :when_rejected
      end

    end
  end
end
