module IsA
  class Characteristic

    include Mongoid::Document

    has_and_belongs_to_many :categories

    field :name

  end
end