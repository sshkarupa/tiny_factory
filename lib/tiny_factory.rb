require "tiny_factory/version"
require "tiny_factory/factory"
require "tiny_factory/attribute"
require "tiny_factory/strategy/attributes_for"
require "tiny_factory/strategy/build"
require "tiny_factory/strategy/create"
require "tiny_factory/syntax/methods"

module TinyFactory
  @factories = []

  def self.factories
    @factories
  end

  # To prevent duplication we are skipping the registration for an existing factory.
  # Another option is to throw an error if the factory is already registered.
  def self.register_factory(factory)
    return if find_factory(factory.factory_name)

    @factories << factory
  end

  def self.define(name, &block)
    factory = Factory.new(name)
    factory.instance_eval(&block)
    register_factory(factory)
    factory
  end

  def self.attributes_for(factory_name)
    find_factory(factory_name).run(Strategy::AttributesFor)
  end

  def self.build(factory_name)
    find_factory(factory_name).run(Strategy::Build)
  end

  def self.create(factory_name)
    find_factory(factory_name).run(Strategy::Create)
  end

  def self.find_factory(factory_name)
    factories.find { |factory| factory.factory_name == factory_name }
  end
end
