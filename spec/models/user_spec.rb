require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context 'creating users' do  # (almost) plain English
    it 'cannot create users' do   #
      expect { User.create! }.to raise_error(ActiveRecord::RecordInvalid)  # test code
    end
  end
end
