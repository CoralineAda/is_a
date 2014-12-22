module IsA
  class Characteristic

    include Mongoid::Document

    has_and_belongs_to_many :categories

    field :name

    before_create :singularize_word

    def singularize_word
      self.name = self.name.singularize
    end

  end
end