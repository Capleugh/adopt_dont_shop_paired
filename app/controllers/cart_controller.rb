class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def update
    pet = Pet.find(params[:pet_id])
    pet_id_str = pet.id.to_s
    session[:cart] ||= Hash.new(0)
    session[:cart][pet_id_str] ||= 0
    session[:cart][pet_id_str] = pet

    flash[:notice] = "#{pet.name} has been faved to your favorites list!"

    redirect_to "/pets/#{params[:pet_id]}"
  end
end
