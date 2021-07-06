# frozen_string_literal: true

module TinyFactory
  class Factory
    attr_reader :factory_name, :attributes

    def initialize(factory_name)
      @factory_name = factory_name
      @attributes = []
    end

    def add_attribute(name, definition)
      @attributes << Attribute.new(name, definition)
    end

    def method_missing(name, &block)
      add_attribute(name, block)
    end

    def run(strategy_class)
      strategy = strategy_class.new(build_class)
      attributes.each do |attribute|
        attribute.add_to(strategy)
      end
      strategy.result
    end

    private

    def build_class
      factory_name.to_s.classify.constantize
    end
  end
end
