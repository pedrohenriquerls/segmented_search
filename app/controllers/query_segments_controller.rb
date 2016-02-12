class QuerySegmentsController < ApplicationController
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
    byebug
    @query_segment = QuerySegment.new(query_segment_params)

    respond_to do |format|
      if @query_segment.save
        format.html { redirect_to @query_segment, notice: 'Query segment was successfully created.' }
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
        format.html { redirect_to @query_segment, notice: 'Query segment was successfully updated.' }
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
      format.html { redirect_to query_segments_url, notice: 'Query segment was successfully destroyed.' }
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
      params.require(:query_segment).permit(:name, :params)
    end
end
