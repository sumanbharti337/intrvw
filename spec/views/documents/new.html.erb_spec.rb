require 'rails_helper'

RSpec.describe "documents/new", type: :view do
  before(:each) do
    assign(:document, Document.new(
      doc_type: 1,
      name: "MyString",
      patient: nil
    ))
  end

  it "renders new document form" do
    render

    assert_select "form[action=?][method=?]", documents_path, "post" do

      assert_select "input[name=?]", "document[doc_type]"

      assert_select "input[name=?]", "document[name]"

      assert_select "input[name=?]", "document[patient_id]"
    end
  end
end
