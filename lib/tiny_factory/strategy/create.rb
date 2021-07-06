# frozen_string_literal: true

module TinyFactory
  module Strategy
    class Create < Build
      def result
        @instance.tap(&:save!)
      end
    end
  end
end
