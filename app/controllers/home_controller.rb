class HomeController < ApplicationController
  def index
  end

  def csv
    redirect_to :index
  end
end
