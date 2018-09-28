module VueRailsTodo
  module CommentRenderer
    # Renderer to replace ![fact] with a random fact about space
    class SpaceFacts < Base
      class << self
        # Read space facts from the filesystem and cache them on the class we
        # don't need to keep reloading them.
        #
        # @return [Array<String>] An array of space facts
        def space_facts
          @space_facts ||= File.read(space_facts_path).split("\n")
        end

        # @return [Path] Location of the space facts on the file system
        def space_facts_path
          @space_facts_path ||= Rails.root.join('db', 'space_facts.txt')
        end
      end

      # Replace ![fact] with a random space fact
      #
      # @param text [String] Text that has no space facts
      #
      # @return [String] Text now with space facts!
      def render(text)
        output = text.gsub('![fact]', random_fact)
        output
      end

      private

      # @return [String] Random space fact
      def random_fact
        self.class.space_facts.sample
      end
    end
  end
end
