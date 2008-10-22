module Onlist::ClassMethods

  def self.extended(base)
    register_association base
    register_named_scopes base
    define_callbacks base
  end
  def self.register_association(base)
    base.has_one :oli,
      :as => :onlisted,
      :class_name => 'Onlist',
      :dependent => :delete
  end
  def self.register_named_scopes(base)
    base.named_scope :unlisted,
      :joins => :oli,
      :conditions => {'onlists.id' => nil}
    base.named_scope :accepted,
      :joins => :oli,
      :conditions => {'onlists.accepted' => true}
    base.named_scope :rejected,
      :joins => :oli,
      :conditions => {'onlists.accepted' => false}
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

end
