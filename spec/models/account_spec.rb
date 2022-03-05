require "rails_helper"  # this

RSpec.describe Account, type: :model  do

  describe "generate_trends" do
    it "generates trends for the last hour, 12 hours, and day" do
      expected_result = [
        
      ]
      # expect(Account.generate_trends).to eq(expected_result)
    end
  end
  
end
