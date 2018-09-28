module VueRailsTodo
  module CommentRenderer
    class SpaceFacts
      class << self
        def space_facts
          @space_facts ||= File.read(space_facts_path).split("\n")
        end

        def space_facts_path
          @space_facts_path ||= Rails.root.join('db', 'space_facts.txt')
        end
      end

      def render(text)
        output = text.gsub('![fact]', random_fact)
        output
      end

      private

      def random_fact
        self.class.space_facts.sample
      end
    end
  end
end
