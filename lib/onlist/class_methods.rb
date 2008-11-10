module Onlist::ClassMethods

  def self.extended(base)
    register_association base
    define_callbacks base
    register_named_scopes base
  end
  def self.register_association(base)
    base.has_one :oli,
      :as => :onlisted,
      :class_name => 'Onlist',
      :dependent => :delete
  end
  def self.define_callbacks(base)
    base.define_callbacks :when_accepted, :when_rejected
  end

  def accept(id)
    entry = find id, :include => :oli
    entry.onlist.accept
  end
  def reject(id)
    entry = find id, :include => :oli
    entry.onlist.reject
  end

  def self.register_named_scopes(base)
    base.named_scope :unlisted,
      :joins => "LEFT OUTER JOIN onlists ON onlists.onlisted_id = #{ base.quoted_table_name }.#{ base.primary_key } AND onlists.onlisted_type = #{ base.quote_value base.base_class.name, base.columns_hash[base.inheritance_column] }",
      :conditions => {'onlists.id' => nil}
    base.named_scope :accepted,
      :joins => :oli,
      :conditions => {'onlists.accepted' => true}
    base.named_scope :rejected,
      :joins => :oli,
      :conditions => {'onlists.accepted' => false}
  end

end

module Onlist::Blacklist::ClassMethods
  include Onlist::ClassMethods

  def self.extended(base)
    Onlist::ClassMethods.register_association base
    Onlist::ClassMethods.define_callbacks base
    Onlist::ClassMethods.register_named_scopes base

    class << base; alias_method :accepted, :unlisted; end
  end

end

module Onlist::Whitelist::ClassMethods
  include Onlist::ClassMethods

  def self.extended(base)
    Onlist::ClassMethods.register_association base
    Onlist::ClassMethods.define_callbacks base
    Onlist::ClassMethods.register_named_scopes base

    class << base; alias_method :rejected, :unlisted; end
  end

end
