class PagesController < ActionController::Base

  def index
  end

  def show
    render :action => params['page']
  end

end
