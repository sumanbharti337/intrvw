require 'rails_helper'

RSpec.describe "documents/edit", type: :view do
  before(:each) do
    @document = assign(:document, Document.create!(
      doc_type: 1,
      name: "MyString",
      patient: nil
    ))
  end

  it "renders the edit document form" do
    render

    assert_select "form[action=?][method=?]", document_path(@document), "post" do

      assert_select "input[name=?]", "document[doc_type]"

      assert_select "input[name=?]", "document[name]"

      assert_select "input[name=?]", "document[patient_id]"
    end
  end
end
