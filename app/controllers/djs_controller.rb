class DjsController < ApplicationController

  skip_before_action :authenticate_user!, only: :index
  before_action :authorize_dj_owner, only: [:edit, :update, :destroy]

    # PG SEARCH implementation
    # if params[:query].present?
    #   @djs = Dj.global_search(params[:query])

  def index
    if params[:query].present?
      sql_subquery = <<~SQL
        djs.name ILIKE :query
        OR djs.location ILIKE :query
        OR genres.category ILIKE :query
      SQL
      @djs = Dj.joins(:genre).where(sql_subquery, query: "%#{params[:query]}%")

      if params[:query].to_i.to_s == params[:query]
        rate = params[:query].to_i

        if rate <= 50
          @djs_rate = Dj.where(rate: 0..50)
        elsif rate > 50 && rate <= 100
          @djs_rate = Dj.where(rate: 51..100)
        elsif rate > 100 && rate <= 150
          @djs_rate = Dj.where(rate: 101..150)
        elsif rate > 150 && rate <= 200
          @djs_rate = Dj.where(rate: 151..200)
        elsif rate > 200 && rate <= 250
          @djs_rate = Dj.where(rate: 201..250)
        elsif rate > 250 && rate <= 300
          @djs_rate = Dj.where(rate: 251..300)
        elsif rate > 300 && rate <= 350
          @djs_rate = Dj.where(rate: 301..350)
        else
          @djs_rate = Dj.where("rate > ?", 350)
        end

        @djs = @djs.or(@djs_rate)
      end
    else
      @djs = Dj.all
    end
  end

  def new
    @dj = Dj.new
  end

  def show
    @dj = Dj.find(params[:id])
  end

  def create
    @dj = Dj.new(dj_params)
    @dj.user = current_user
    if @dj.save
      redirect_to dj_path(@dj)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @dj = Dj.find(params[:id])
    render :new
  end

  def update
    @dj = Dj.find(params[:id])

    if @dj.update(dj_params)
      redirect_to dj_path(@dj), notice: "DJ Listing updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @dj = Dj.find(params[:id])

    unless @dj.user == current_user
      flash[:alert] = "You are not allowed to delete this DJ. For more information, contact admin@admin.nz"
      redirect_to @dj
    end

    if @dj.destroy
      redirect_to djs_path, notice: "DJ Listing deleted successfully."
    else
      flash[:alert] = "Failed to delete DJ Listing."
      redirect_to @dj
    end
  end

  private

  def dj_params
    params.require(:dj).permit(:name, :genre_id, :rate, :description, :photo, :link)
  end

  def authorize_dj_owner
    @dj = Dj.find(params[:id])
    unless @dj.user == current_user
      flash[:alert] = "You are not allowed to edit this DJ. For more information, contact admin@admin.nz"
      redirect_to @dj
    end
  end
end
