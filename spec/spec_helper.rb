require "bundler/setup"
require "tiny_factory"
require "active_record"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

ActiveRecord::Base.establish_connection(
  database: ":memory:",
  adapter: "sqlite3"
)

class CreateSchema < ActiveRecord::Migration[6.0]
  def self.up
    create_table :users, force: true do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
    end
  end
end

CreateSchema.migrate(:up)

class User < ActiveRecord::Base
  validates :first_name, :last_name, :email, presence: true
end
