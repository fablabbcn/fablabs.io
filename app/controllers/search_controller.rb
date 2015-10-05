class SearchController < ApplicationController

  before_filter :require_login, except: :index

  def index
    respond_to do |format|
      format.html
    end
  end
