class StatesController < ApplicationController

  def expired
    @brunch = current_user.brunches.find(params[:id])

    @exp_products = @brunch.products.where(state: "Expierd")
  end

  def almost_exp
    @exp_products = current_user.products.where(state: "Almost expierd")
  end

  def good
    @exp_products = current_user.products.where(state: "New")
  end
end
