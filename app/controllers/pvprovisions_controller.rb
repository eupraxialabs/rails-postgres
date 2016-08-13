class PvprovisionsController < ApplicationController
  before_action :set_pvprovision, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "pvprovisions", "/pvprovisions"

  # GET /pvprovisions
  # GET /pvprovisions.json
  def index
    @pvprovisions = Pvprovision.all
  end

  # GET /pvprovisions/1
  # GET /pvprovisions/1.json
  def show
  end

  # GET /pvprovisions/new
  def new
    @pvprovision = Pvprovision.new
  end

  # GET /pvprovisions/1/edit
  def edit
  end

  # POST /pvprovisions
  # POST /pvprovisions.json
  def create
    @pvprovision = Pvprovision.new(pvprovision_params)

    respond_to do |format|
      if @pvprovision.save
        format.html { redirect_to @pvprovision, notice: 'Pvprovision was successfully created.' }
        format.json { render :show, status: :created, location: @pvprovision }
      else
        format.html { render :new }
        format.json { render json: @pvprovision.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pvprovisions/1
  # PATCH/PUT /pvprovisions/1.json
  def update
    respond_to do |format|
      if @pvprovision.update(pvprovision_params)
        format.html { redirect_to @pvprovision, notice: 'Pvprovision was successfully updated.' }
        format.json { render :show, status: :ok, location: @pvprovision }
      else
        format.html { render :edit }
        format.json { render json: @pvprovision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pvprovisions/1
  # DELETE /pvprovisions/1.json
  def destroy
    @pvprovision.destroy
    respond_to do |format|
      format.html { redirect_to pvprovisions_url, notice: 'Pvprovision was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pvprovision
      @pvprovision = Pvprovision.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pvprovision_params
      params.fetch(:pvprovision, {})
    end
end
