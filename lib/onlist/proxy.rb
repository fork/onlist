class Onlist::Proxy

  def initialize(item)
    @item = item
  end

  def conditions(extras = {})
    {
      :onlisted_type => @item.class.base_class.name,
      :onlisted_id   => @item.id
    }.
    merge extras
  end

  def entry
    @item.oli || @item.build_oli
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
