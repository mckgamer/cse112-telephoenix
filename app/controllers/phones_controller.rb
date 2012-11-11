class PhonesController < ApplicationController
  def index
    @phones = Phone.all
  end

  def show
    @phone = Phone.find(params[:id])
    @tags = Tag.find_all_by_phone_id(params[:id])
    @ratings = Rating.find_all_by_phone_id(params[:id])
  end
end
