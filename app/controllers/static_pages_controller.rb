class StaticPagesController < ApplicationController
  def about
  end

  def hello
    render text: "Welcome to the SampleApp!"
  end      

  def home
  end

  def help
  end
end
