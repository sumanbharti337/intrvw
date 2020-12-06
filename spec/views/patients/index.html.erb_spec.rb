require 'rails_helper'

RSpec.describe "patients/index", type: :view do
  before(:each) do
    assign(:patients, [
      Patient.create!(
        name: "Name",
        age: 2,
        email: "Email",
        mobile: "Mobile"
      ),
      Patient.create!(
        name: "Name",
        age: 2,
        email: "Email",
        mobile: "Mobile"
      )
    ])
  end

  it "renders a list of patients" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "Email".to_s, count: 2
    assert_select "tr>td", text: "Mobile".to_s, count: 2
  end
end
