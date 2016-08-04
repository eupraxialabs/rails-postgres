class PvcrequestsController < ApplicationController
  before_action :set_pvcrequest, only: [:show, :edit, :update, :destroy]

  # GET /pvcrequests
  # GET /pvcrequests.json
  def index
    @pvcrequests = Pvcrequest.all
  end

  # GET /pvcrequests/1
  # GET /pvcrequests/1.json
  def show
  end

  # GET /pvcrequests/new
  def new
    @pvcrequest = Pvcrequest.new
  end

  # GET /pvcrequests/1/edit
  def edit
  end

  # POST /pvcrequests
  # POST /pvcrequests.json
  def create
    @pvcrequest = Pvcrequest.new(pvcrequest_params)

    respond_to do |format|
      if @pvcrequest.save
        format.html { redirect_to @pvcrequest, notice: 'Pvcrequest was successfully created.' }
        format.json { render :show, status: :created, location: @pvcrequest }
      else
        format.html { render :new }
        format.json { render json: @pvcrequest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pvcrequests/1
  # PATCH/PUT /pvcrequests/1.json
  def update
    respond_to do |format|
      if @pvcrequest.update(pvcrequest_params)
        format.html { redirect_to @pvcrequest, notice: 'Pvcrequest was successfully updated.' }
        format.json { render :show, status: :ok, location: @pvcrequest }
      else
        format.html { render :edit }
        format.json { render json: @pvcrequest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pvcrequests/1
  # DELETE /pvcrequests/1.json
  def destroy
    @pvcrequest.destroy
    respond_to do |format|
      format.html { redirect_to pvcrequests_url, notice: 'Pvcrequest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pvcrequest
      @pvcrequest = Pvcrequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pvcrequest_params
      params.fetch(:pvcrequest, {})
    end
end
