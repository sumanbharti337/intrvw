class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  # GET /patients
  # GET /patients.json
  def index
    # @patients = Patient.all
    respond_to do |format|
      format.html
      format.json { render json: PatientDatatable.new(params, view_context: view_context) }
    end
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, notice: 'Patient was successfully created.' }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def doc_csv
    @patients = Patient.all

    respond_to do |format|
      format.html
      format.csv { send_data @patients.to_csv, filename: "patient-doc-#{Date.today}.csv" }
    end
  end

  def xml_sitemap
    @patients = Patient.includes(:documents).all

    respond_to do |format|
      format.html
      format.xml { render xml: @patients.as_json(only: [:id, :name, :age, :email, :mobile], skip_types: true, root: true, include: {documents: {only: [:name, :doc_type]}}) }
    end
  end

  def doc_json
    @patients = Patient.includes(:documents).all

    respond_to do |format|
      format.html
      format.json { render :json => @patients.as_json(only: [:id, :name, :age, :email, :mobile], skip_types: true, root: true, include: {documents: {only: [:name, :doc_type]}}) }
    end
  end

  def import
    file = params[:file]
    if file
      Patient.import(params[:file])
      msg = "Activity Data Imported."
    else
      msg = "No input given."
    end
    redirect_to patients_url, :notice => msg
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def patient_params
      params.require(:patient).permit(:name, :age, :email, :mobile)
    end
end
