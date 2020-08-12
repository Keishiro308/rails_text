require 'rails_helper'

RSpec.describe Administrator, type: :model do
  describe "#password=" do
    example "文字列を与えるとhashed_passwordには長さ６０の文字列が入る" do
      admin = Administrator.new
      admin.password = "admin"
      expect(admin.hashed_password).to be_kind_of(String)
      expect(admin.hashed_password.size).to eq(60)
    end

    example "nilを与えるとhashed_passwordはnilになる" do
      admin = Administrator.new(hashed_password: "A")
      admin.password = nil
      expect(admin.hashed_password).to be_nil
    end
  end
end
