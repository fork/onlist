class Test::Spec::Should

  def belong_to(assoc_name)
    reflection = @object.reflect_on_association assoc_name

    assert_kind_of ActiveRecord::Reflection::AssociationReflection, reflection
    assert_equal :belongs_to, reflection.macro, @message
  end
  def have_many(assoc_name)
    reflection = @object.reflect_on_association assoc_name

    assert_kind_of ActiveRecord::Reflection::AssociationReflection, reflection
    assert_equal :has_many, reflection.macro, @message
  end
  def have_one(assoc_name)
    reflection = @object.reflect_on_association assoc_name

    assert_kind_of ActiveRecord::Reflection::AssociationReflection, reflection
    assert_equal :has_one, reflection.macro, @message
  end

  def be_composed_of(name)
    aggregation = @object.reflect_on_aggregation name
    assert_kind_of ActiveRecord::Reflection::AggregationReflection, aggregation
  end

end
