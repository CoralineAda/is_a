module IsA
  class Category

    include Mongoid::Document

    belongs_to :category
    has_many :categories
    has_and_belongs_to_many :characteristics

    field :name

    before_create :singularize_word

    def singularize_word
      self.name = self.name.singularize
    end

    def is_a?(thing=self, classification)
      return true if thing.parent == classification
      return false if thing.parent.nil?
      is_a?(thing.parent, classification)
    end

    def has_a?(classification=self, thing)
      return false unless self.categories.any?
      return true if self.categories.include?(thing)
      self.categories.detect{|c| c.has_a?(c, thing)}
    end

    def any_child_has?(classification=self, characteristic)
      return false unless self.categories.any?
      self.categories.detect{|c| c.has?(characteristic) || c.any_child_has?(c, characteristic)}
    end

    def any_parent_has?(classification=self, characteristic)
      return false unless self.parent
      self.parent.has?(characteristic)
    end

    def is_a!(category)
      category.categories << self
      update_attributes(category_id: category.id)
    end

    def connected?
      self.parent || self.categories.any?
    end

    def has?(characteristic)
      self.characteristics.include? characteristic
    end

    def has!(characteristic)
      self.characteristics << characteristic
    end

    def is_sibling?(category)
      category.parent == self.parent
    end

    def parent
      self.category
    end

    def plural_name
      self.name.pluralize
    end

  end
end