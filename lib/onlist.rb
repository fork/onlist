# Author:: Florian Aßmann (flazy@fork.de)
class Onlist < ActiveRecord::Base

  belongs_to :onlisted, :polymorphic => true

  after_save :update_timestamp_of_onlisted
  after_destroy :update_timestamp_of_onlisted

  def update_timestamp_of_onlisted
    column      = onlisted.onlist_options[:updates] or return
    updates     = { column => frozen?? Time.now : updated_at }
    conditions  = { onlisted.class.primary_key => onlisted.id }

    onlisted.class.update_all updates, conditions
  end
  protected :update_timestamp_of_onlisted

  Whitelist = Module.new
  Blacklist = Module.new

end
