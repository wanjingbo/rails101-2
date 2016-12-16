class WelcomeController < ApplicationController
  def index
    flash[:warning] = "zaoan! nihao "
  end
end
