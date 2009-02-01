# Author:: Florian Aßmann (flazy@fork.de)
class Onlist::Entry < ActiveRecord::Base
  self.table_name = 'onlist'
  belongs_to :listed, :polymorphic => true
end
