class DjsController < ApplicationController

  def index

    @djs = Dj.all

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

  if @dj.destroy
    redirect_to djs_path, notice: "DJ Listing deleted successfully."
  else
    redirect_to dj_path(@dj), alert: "Failed to delete DJ Listing."
  end
end







#

private

  def dj_params
    params.require(:dj).permit(:name, :genre_id, :rate, :description, :photo, :link)
  end


end
