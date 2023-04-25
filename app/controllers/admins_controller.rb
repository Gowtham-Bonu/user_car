class AdminsController < ApplicationController
  http_basic_authenticate_with name: "gowtham", password: "gogo"
  
  def index
  end
end
