class LocalesController < ApplicationController
  def index
    render json: I18n.t('.')
  end
end
