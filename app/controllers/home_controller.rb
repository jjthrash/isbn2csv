class HomeController < ApplicationController
  def index
    #isbns = params[:csv][:isbns].split(/\D+/)
  end

  def csv
    redirect_to :index
  end
end
