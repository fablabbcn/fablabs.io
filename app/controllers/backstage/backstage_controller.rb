class Backstage::BackstageController < ApplicationController
  before_filter :require_login
end
