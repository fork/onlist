# Author:: Florian Aßmann (flazy@fork.de)
class Onlist < ActiveRecord::Base

  belongs_to :onlisted, :polymorphic => true

  after_save :update_timestamp_of_onlisted
  after_destroy :update_timestamp_of_onlisted

  def update_timestamp_of_onlisted
    column = onlisted.onlist_options[:updates] or return
    onlisted.class.update onlisted.id, column => updated_at
  end
  protected :update_timestamp_of_onlisted

end
