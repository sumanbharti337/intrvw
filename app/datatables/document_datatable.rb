class DocumentDatatable < AjaxDatatablesRails::ActiveRecord

  extend Forwardable

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      # id: { source: "User.id", cond: :eq },
      # name: { source: "User.name", cond: :like }
      id:         { source: "Document.id" },
      doc_type:   { source: "Document.doc_type", formatter: -> (o) { o.upcase } },
      name:       { source: "Document.name", formatter: -> (o) { o.upcase } },
    }
  end

  def data
    records.each_with_index.map do |record, i|
      {
          id:         (i+1),
          doc_type:   record.doc_type,
          name:       record.name,
          DT_RowId:   record.id, # This will automatically set the id attribute on the corresponding <tr> in the datatable
      }
    end
  end

  def get_raw_records
    # insert query here
    # User.all
    Document.all
  end

end
