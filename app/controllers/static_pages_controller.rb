class StaticPagesController < ApplicationController
  def hello
    render text: "Welcome to the SampleApp!"
  end      

  def home
  end

  def help
  end
end
