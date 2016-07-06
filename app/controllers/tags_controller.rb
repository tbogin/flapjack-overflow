class TagsController < ApplicationController


  def index
    erb :'tags/index'
  end

  def show
    @tag = Tag.find_by(id: params[:id])
    erb :'tags/show'
  end

end
