class PatientDatatable < AjaxDatatablesRails::ActiveRecord

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
        id:       { source: "Patient.id" },
        name:     { source: "Patient.name", formatter: -> (o) { o.upcase } },
        age:      { source: "Patient.age" },
        email:    { source: "Patient.email" },
        mobile:   { source: "Patient.mobile" },
    }
  end

  def data
    records.map do |record|
      {
        # example:
        # id: record.id,
        # name: record.name
      }
    end

    records.each_with_index.map do |record, i|
      # puts record.roles[name]
      {
          id:         (i+1),
          name:       record.name,
          age:        record.age,
          email:      record.email,
          mobile:     record.mobile,
          DT_RowId:   record.id, # This will automatically set the id attribute on the corresponding <tr> in the datatable
      }
    end
  end

  def get_raw_records
    # insert query here
    Patient.all
  end

end
