module IsA
  class Parser

    attr_reader :text

    ARTICLES = ["a", "an", "the"]

    def initialize(text)
      @text = text
      @statement = Question.new(text) if is_question?
      @statement ||= Definition.new(text)
    end

    def response
      @statement.response
    end

    def is_question?
      text =~ /\?$/
    end

    class Question

      attr_reader :text

      def initialize(text)
        @text = text
      end

      def subject
        Category.find_or_create_by(name: (text.downcase.split - Parser::ARTICLES)[2])
      end

      def object
        Category.find_or_create_by(name: (text.downcase.split - Parser::ARTICLES)[-1])
      end

      def response
        subject.is_a?(object) ? "Yes." : "I don't think so."
      end

    end

    class Definition

      attr_reader :text

      def initialize(text)
        @text = text
      end

      def subject
        Category.find_or_create_by(name: (text.downcase.split - Parser::ARTICLES)[1])
      end

      def object
        Category.find_or_create_by(name: (text.downcase.split - Parser::ARTICLES)[-1])
      end

      def response
        subject.is_a! object
        "Okay."
      end

    end

  end
end