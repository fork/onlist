module Onlist
  module Blacklist
    module ClassMethods
      include ::Onlist::ClassMethods

      def self.extended(base)
        Onlist::ClassMethods.register_association base
        Onlist::ClassMethods.define_callbacks base
        Onlist::ClassMethods.register_named_scopes base
        base.class_eval { scopes[:accepted] = scopes[:unlisted] }
      end

    end
  end
end