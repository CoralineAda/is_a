module IsA
  class Category

    include Mongoid::Document

    belongs_to :category
    has_many :categories, as: :children

    field :name

    def is_a?(thing=self, classification)
      return true if thing.parent == classification
      return false if thing.parent.nil?
      is_a?(thing.parent, classification)
    end

    def is_a!(category)
      update_attribute(:category_id, category.id)
    end

    def parent
      self.category
    end

  end
end