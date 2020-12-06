require 'rails_helper'

RSpec.describe "documents/index", type: :view do
  before(:each) do
    assign(:documents, [
      Document.create!(
        doc_type: 2,
        name: "Name",
        patient: nil
      ),
      Document.create!(
        doc_type: 2,
        name: "Name",
        patient: nil
      )
    ])
  end

  it "renders a list of documents" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
