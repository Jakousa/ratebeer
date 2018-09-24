class StylesController < ApplicationController
  def index
    @styles = Style.all
  end

  # GET /styles/1
  # GET /styles/1.json
  def show
    @style = Style.find(params[:id])
  end
end
