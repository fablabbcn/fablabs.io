class Api::CsrfController < ApplicationController
  def index
    render json: { request_forgery_protection_token => form_authenticity_token }.to_json
  end
end
