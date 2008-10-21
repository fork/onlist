class Onlist < ActiveRecord::Base

  belongs_to :onlisted, :polymorphic => true

  after_save :update_timestamp_of_onlisted
  after_destroy :update_timestamp_of_onlisted

  def update_timestamp_of_onlisted
    column = onlisted.onlist_options[:updates] or return
    onlisted.class.update onlisted.id, column => updated_at
  end
  protected :update_timestamp_of_onlisted

  module ClassMethods
    # onlist :updates => :updated_at
    def onlist(opts)
      has_one :oli,
        :as => :onlisted,
        :class_name => 'Onlist',
        :dependent => :delete

      self.class_inheritable_reader :onlist_options
      self.inheritable_attributes[:onlist_options] = opts

      named_scope :unlisted,
        :joins => :oli,
        :conditions => {'onlists.id' => nil}
      named_scope :accepted,
        :joins => :oli,
        :conditions => {'onlists.accepted' => true}
      named_scope :rejected,
        :joins => :oli,
        :conditions => {'onlists.accepted' => false}

      define_callbacks :when_accepted, :when_rejected

      include Onlist::InstanceMethods
    end
  end
  
  module InstanceMethods
    def onlist
      Onlist::Method.new self
    end
    def accepted?
      Onlist.exists? onlist.conditions(:accepted => true)
    end
    def rejected?
      Onlist.exists? onlist.conditions(:accepted => false)
    end
    def unlisted?
      onlist.entry.new_record?
    end
  end

  class Method
    def initialize(item)
      @item = item
    end
    def conditions(extras = {})
      {
        :enlisted_type => @item.class.base_class,
        :enlisted_id   => @item.id
      }.
      merge extras
    end
    def entry
      @item.onlisted || @item.build_onlisted
    end
    def accept
      entry.accepted = true
      entry.save and run_callbacks(:when_accepted)
    end
    def reject
      entry.accepted = false
      entry.save and run_callbacks(:when_rejected)
    end
  end

end
