class StylesController < ApplicationController
  before_action :ensure_that_admin, only: [:destroy]

  def index
    @styles = Style.all
  end

  # GET /styles/1
  # GET /styles/1.json
  def show
    @style = Style.find(params[:id])
  end

  def destroy
  end
end
