class MediaFilesController < ApplicationController
  before_action :set_media_file, only: [:show, :edit, :update, :destroy, :stage]

  # GET /media_files
  # GET /media_files.json
  def index
    @media_files = MediaFile.all
  end

  # GET /media_files/1
  # GET /media_files/1.json
  def show
    @store_resp = RestClient.get 'http://localhost:3000/storage_api/stores/' + @media_file.store + '/media_files/' + @media_file.name
    @cache_resp = RestClient.get 'http://localhost:3000/storage_api/caches/' + @media_file.cache +  '/cache_files/' + @media_file.name
  end

  # GET /media_files/new
  def new
    @media_file = MediaFile.new
  end

  # GET /media_files/1/edit
  def edit
  end

  # POST /media_files
  # POST /media_files.json
  def create
    @media_file = MediaFile.new(media_file_params)

    respond_to do |format|
      if @media_file.save
        format.html { redirect_to @media_file, notice: 'Media file was successfully created.' }
        format.json { render :show, status: :created, location: @media_file }
      else
        format.html { render :new }
        format.json { render json: @media_file.errors, status: :unprocessable_entity }
      end
    end
  end

  def stage
    @store_resp = RestClient.post 'http://localhost:3000/storage_api/jobs/' + @media_file.cache + '/' + @media_file.name, :type => 'stage'
    redirect_to @media_file, notice: 'A job to stage this media file has been initiated.'
  end

  # PATCH/PUT /media_files/1
  # PATCH/PUT /media_files/1.json
  def update
    respond_to do |format|
      if @media_file.update(media_file_params)
        format.html { redirect_to @media_file, notice: 'Media file was successfully updated.' }
        format.json { render :show, status: :ok, location: @media_file }
      else
        format.html { render :edit }
        format.json { render json: @media_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media_files/1
  # DELETE /media_files/1.json
  def destroy
    @media_file.destroy
    respond_to do |format|
      format.html { redirect_to media_files_url, notice: 'Media file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_media_file
      @media_file = MediaFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def media_file_params
      params.require(:media_file).permit(:name, :store, :cache, :description)
    end
end
