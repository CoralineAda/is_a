module IsA
  class Category

    include Mongoid::Document

    belongs_to :category
    has_many :categories, as: :children

    field :name

    def is_a?(category)
      return true if parent == category
      return false if parent.nil?
      is_a?(category.parent)
    end

    def parent
      self.category
    end

  end
end