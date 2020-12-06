class Document < ApplicationRecord
  require 'csv'
  require 'nokogiri'

  belongs_to :patient
  enum doc_type: { xls: 2, doc: 2, pdf: 1, image: 0 }
  STATUS_OPTIONS = %w(xls doc csv image)
  validates :doc_type, :inclusion => {:in => STATUS_OPTIONS}
  has_many_attached :images

  def self.import(file)
    if file.content_type == "text/csv"
      CSV.foreach(file.path, headers:true) do |row|
        Document.create! row.to_hash rescue nil
      end
    elsif file.content_type == "text/xml"
      doc = Nokogiri::XML(File.open(file))
      doc.css("document").each do |node|
        doc_type = node.at_xpath('doc_type').content
        name = node.at_xpath('name').content
        patient_id = node.at_xpath('patient_id').content
        data = {:doc_type => doc_type, :name => name, :patient_id => patient_id }
        Document.create(data) rescue nil
      end
    elsif file.content_type == "application/json"
      document_list = JSON.parse(File.read(file))
      document_list.each do |document|
        Document.create(document.to_h) rescue nil
      end
    end
  end

  def self.to_csv(options = {})
    attributes = %w{id doc_type doc_name pat_name, link}
    CSV.generate(options) do |csv|
      # csv << column_names
      csv << attributes
      all.each do |document|
        dd = []
       document.images.each do |file|
         dd << (file.filename).to_s
       end
        puts dd.join(",")
        csv << [document.id, document.doc_type, document.name, document.patient.name, dd.join(",")]
        # csv << document.attributes.values_at(*column_names)
      end
    end
  end
end
