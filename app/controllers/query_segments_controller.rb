class QuerySegmentsController < ApplicationController
  include RedirectMessage
  MODEL_NAME = 'Query Segment'

  before_action :set_query_segment, only: [:show, :edit, :update, :destroy]

  # GET /query_segments
  # GET /query_segments.json
  def index
    @query_segments = QuerySegment.all
  end

  # GET /query_segments/1
  # GET /query_segments/1.json
  def show
  end

  # GET /query_segments/new
  def new
    @query_segment = QuerySegment.new
  end

  # GET /query_segments/1/edit
  def edit
  end

  # POST /query_segments
  # POST /query_segments.json
  def create
    @query_segment = QuerySegment.new(query_segment_params)
    respond_to do |format|
      if @query_segment.save
        format.html { redirect @query_segment, 'save', MODEL_NAME }
        format.json { render :show, status: :created, location: @query_segment }
      else
        format.html { render :new }
        format.json { render json: @query_segment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /query_segments/1
  # PATCH/PUT /query_segments/1.json
  def update
    respond_to do |format|
      if @query_segment.update(query_segment_params)
        format.html { render :show, location: @query_segment, notice:  I18n.t('activerecord.messages.update_success', model: MODEL_NAME) }
        format.json { render :show, status: :ok, location: @query_segment }
      else
        format.html { render :edit }
        format.json { render json: @query_segment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /query_segments/1
  # DELETE /query_segments/1.json
  def destroy
    @query_segment.destroy
    respond_to do |format|
      format.html { redirect query_segments_url, 'delete', MODEL_NAME }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_query_segment
      @query_segment = QuerySegment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def query_segment_params
      params.require('query_segment').permit('name', 'criteria')
    end
end
