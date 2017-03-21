# class ApplicationController < ActionController::Base
#   include Clearance::Controller
#   protect_from_forgery with: :exception
# end

class ArticlesController < ApplicationController
  before_action :require_login

  def index
    current_user.articles
  end
end
