module IsA
  class Characteristic

    include Mongoid::Document

    has_and_belongs_to_many :categories

    field :name
    field :stem

    before_create, :stem_word

    def stem_word
      self.stem = Lingua.stemmer(self.base_form)
    end

  end
end