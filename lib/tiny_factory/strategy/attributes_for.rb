# frozen_string_literal: true

module TinyFactory
  module Strategy
    class AttributesFor
      def initialize(_)
        @result = {}
      end

      def get(attribute)
        @result[attribute]
      end

      def set(attribute, value)
        @result[attribute] = value
      end

      def method_missing(attribute)
        get(attribute)
      end

      def result
        @result
      end
    end
  end
end
