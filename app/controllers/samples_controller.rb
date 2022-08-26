class SamplesController < ApplicationController
  before_action :set_sample, only: %i[ show edit update destroy ]

  def index
    @samples = Sample.all
  end

  def show
  end

  def new
    @sample = Sample.new
  end

  def create
    @sample = Sample.new(sample_params)

    respond_to do |format|
      if @sample.save
        format.html { redirect_to sample_url(@sample), notice: "Sample was successfully created." }
        format.json { render :show, status: :created, location: @sample }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sample.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sample.destroy

    respond_to do |format|
      format.html { redirect_to samples_url, notice: "Sample was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_sample
      @sample = Sample.find(params[:id])
    end

    def sample_params
      params.require(:sample).permit(:name, :histogram, :words_count, :cycles)
    end
end
