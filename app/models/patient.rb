class Patient < ApplicationRecord
  has_many :documents, dependent: :destroy

  def self.import(file)
    if file.content_type == "text/csv"
      CSV.foreach(file.path, headers:true) do |row|
        Patient.create! row.to_hash rescue nil
      end
    elsif file.content_type == "text/xml"
      doc = Nokogiri::XML(File.open(file))
      doc.css("patient").each do |node|
        name = node.at_xpath('name').content
        age = node.at_xpath('age').content
        email = node.at_xpath('email').content
        mobile = node.at_xpath('mobile').content
        data = {:name => name, :age => age, :email => email, :mobile => mobile }
        Patient.create(data) rescue nil
      end
    elsif file.content_type == "application/json"
      patient_list = JSON.parse(File.read(file))
      patient_list.each do |patient|
        Patient.create(patient.to_h) rescue nil
      end
    end
  end

  def self.to_csv(options = {})
    attributes = %w{id name age email mobile}
    CSV.generate(options) do |csv|
      csv << attributes
      all.each do |patient|
        csv << [patient.id, patient.name, patient.age, patient.email, patient.mobile]
      end
    end
  end
end
