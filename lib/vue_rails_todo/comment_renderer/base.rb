module VueRailsTodo
  module CommentRenderer
    # @abstract In the absence of interfaces in ruby, this base class serves
    # to demonstrate what each renderer should respond to.
    #
    # Subclass and implement #render to make a concrete class.
    class Base
      # @abstract Transforms text for this render stage
      #
      # @param text [String] Raw, unprocessed text
      #
      # @return [String] Processed text
      def render(text)
        raise NotImplementedError
      end
    end
  end
end
