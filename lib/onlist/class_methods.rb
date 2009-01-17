module Onlist
  module ClassMethods

    def self.extended(base)
      register_association base
      define_callbacks base
      register_named_scopes base
    end
    def self.register_association(base)
      base.has_one :oli,
        :as => :onlisted,
        :class_name => 'Onlist::Entry',
        :dependent => :delete
    end
    def self.define_callbacks(base)
      base.define_callbacks :when_accepted, :when_rejected
    end

    def accept(id)
      entry = find id
      entry.onlist.accept
    end
    def reject(id)
      entry = find id
      entry.onlist.reject
    end

    def self.register_named_scopes(base)
      base.named_scope :unlisted, proc {
        entries = Onlist::Entry.find :all, :select => :onlisted_id,
            :conditions => { :onlisted_type => base.base_class.name }
        entry_ids = entries.map! { |e| e.id }

        qtn = base.quoted_table_name
        qcn = base.connection.quote_column_name base.primary_key

        { :conditions => ["#{ qtn }.#{ qcn } NOT IN (?)", entry_ids] }
      }
      base.named_scope :accepted,
        :joins => :oli,
        :conditions => {'onlist.accepted' => true}
      base.named_scope :rejected,
        :joins => :oli,
        :conditions => {'onlist.accepted' => false}
    end

  end
end