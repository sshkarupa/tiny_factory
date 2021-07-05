RSpec.describe TinyFactory do
  it "has a version number" do
    expect(TinyFactory::VERSION).not_to be nil
  end

  before do
    described_class.define :user do
      first_name { "John" }
      last_name { "Doe" }
      email { "#{first_name}.#{last_name}@hey.com".downcase }
    end
  end

  describe ".attributes_for" do
    subject(:attributes) { described_class.attributes_for(:user) }

    it "creates a hash of attributes" do
      expect(attributes).to be_kind_of(Hash)

      expect(attributes[:first_name]).to eq("John")
      expect(attributes[:last_name]).to eq("Doe")
      expect(attributes[:email]).to eq("john.doe@hey.com")
    end
  end

  describe ".build" do
    subject(:user) { described_class.build(:user) }

    it "builds a user" do
      expect(:user).to be_kind_of(User)
      expect(:user.new_record?).to be_truthy

      expect(user.first_name).to eq("John")
      expect(user.last_name).to eq("Doe")
      expect(user.email).to eq("john.doe@hey.com")
    end
  end

  describe ".create" do
    subject(:user) { described_class.create(:user) }

    it "creates a persisted user" do
      expect(:user).to be_kind_of(User)
      expect(:user.persisted?).to be_truthy

      expect(user.first_name).to eq("John")
      expect(user.last_name).to eq("Doe")
      expect(user.email).to eq("john.doe@hey.com")
    end
  end
end
