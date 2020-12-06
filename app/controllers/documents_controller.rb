require 'csv'
class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    # @documents = Document.all.with_attached_images
    respond_to do |format|
      format.html
      format.json { render json: DocumentDatatable.new(params, view_context: view_context) }
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)
    # @document.images.attach(params[:document][:images])
    respond_to do |format|
      if @document.save
        @records = Document.all.with_attached_images

        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def doc_csv
    @documents = Document.all.with_attached_images

    respond_to do |format|
      format.html
      format.csv { send_data @documents.to_csv, filename: "doc-#{Date.today}.csv" }
    end
  end

  def xml_sitemap
    @documents = Document.all.with_attached_images

    respond_to do |format|
      format.html
      format.xml { render xml: @documents.as_json(only: [:id, :name, :doc_type], skip_types: true, root: true, include: {patient: {only: [:name, :age, :email, :mobile]}, images: {only: [:blob_id], include:{ blob:{only:[:key, :filename]} }}}) }
    end
  end

  def doc_json
    @documents = Document.all.with_attached_images

    respond_to do |format|
      format.html
      format.json { render :json => @documents.to_json(only: [:id, :name, :doc_type], skip_types: true, root: true, include: { patient: {only: [:name, :age, :email, :mobile]}, images: {only: [:blob_id], include:{ blob:{only:[:key, :filename]} }} }) }
    end
  end

  def import
    file = params[:file]
    if file
      Document.import(params[:file])
      msg = "Activity Data Imported."
    else
      msg = "No input given."
    end
    redirect_to root_url, :notice => msg
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def document_params
      params.require(:document).permit(:doc_type, :name, :patient_id, images: [])
    end
end
