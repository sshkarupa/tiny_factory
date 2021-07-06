# frozen_string_literal: true

module TinyFactory
  module Strategy
    class Build
      def initialize(klass)
        @instance = klass.new
      end

      def get(attribute)
        @instance.send(attribute)
      end

      def set(attribute, value)
        @instance.send("#{attribute}=", value)
      end

      def method_missing(attribute)
        get(attribute)
      end

      def result
        @instance
      end
    end
  end
end
