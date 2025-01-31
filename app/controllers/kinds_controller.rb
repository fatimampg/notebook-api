class KindsController < ApplicationController
  before_action :set_kind, only: %i[ show update destroy ]

  # GET /kinds
  def index
    @kinds = Kind.all

    render json: @kinds
  end

  # GET /kinds/1
  def show
    render json: @kind
  end

  # POST /kinds
  def create
    @kind = Kind.new(kind_params)

    if @kind.save
      render json: @kind, status: :created, location: @kind
    else
      render json: @kind.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /kinds/1
  def update
    if @kind.update(kind_params)
      render json: @kind
    else
      render json: @kind.errors, status: :unprocessable_entity
    end
  end

  # DELETE /kinds/1
  def destroy
    @kind.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kind
      if params[:contact_id]
        @kind = Contact.find(params[:contact_id]).kind  # Kind method invoked on Contact obj because of the belongs_to :kind association in Contact model - the kind_id in contacts is then used to find the associated Kind record.
        puts "#Kind id1: #{@kind.inspect} and type: #{@kind.class}"
        return @kind
        # kind_id = Contact.find(params[:contact_id]).kind.id
        # puts "#Kind id1: #{kind_id.inspect} and type: #{kind_id.class}"
        # return @kind = Kind.find(kind_id)
      end

      @kind = Kind.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def kind_params
      params.expect(kind: [ :description ])
    end
end
