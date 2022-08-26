# frozen_string_literal: true

# app/controllers/samples_controller.rb
class SamplesController < ApplicationController
  before_action :set_sample, only: %i[show edit update destroy]
  include SamplesHelper

  def index
    @samples = Sample.all.reverse
  end

  def show
    @sample.histogram = @sample.histogram.sort_by { |_k, v| v.to_i }.reverse.to_h
  end

  def new
    @sample = Sample.new
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/PerceivedComplexity
  def create
    if sample_params[:text_sample].nil? && sample_params[:text_input].nil?
      flash[:alert] = 'Please upload a text file or input the text manually.'
      redirect_to new_sample_url

    else

      @sample = Sample.new
      @sample.name = sample_params[:name]

      sample_counter = SampleCounter.new(@sample)

      sample_counter.count_from_input sample_params[:text_input] unless sample_params[:text_input].nil?

      unless sample_params[:text_sample].nil?
        if validate_file_type sample_params[:text_sample]
          sample_counter.count_from_file sample_params[:text_sample]
        else
          flash[:alert] = 'File must be a text/plain file.'
          return redirect_to new_sample_url
        end
      end

      respond_to do |format|
        if @sample.save
          format.html { redirect_to sample_url(@sample), notice: 'Success!.' }
          format.json { render :show, status: :created, location: @sample }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @sample.errors, status: :unprocessable_entity }
        end
      end
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Metrics/PerceivedComplexity

  def update
    respond_to do |format|
      if @sample.update(sample_params)
        format.html { redirect_to sample_url(@sample), notice: 'Sample was successfully updated.' }
        format.json { render :show, status: :ok, location: @sample }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sample.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sample.destroy
    @sample.text_sample.purge

    respond_to do |format|
      format.html { redirect_to samples_url, notice: 'Sample was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_sample
    @sample = Sample.find(params[:id])
  end

  def sample_params
    params.require(:sample).permit(:name, :histogram, :words_count, :cycles, :text_sample, :text_input, :radio)
  end
end
