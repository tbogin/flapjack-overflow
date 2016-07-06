class TagsController < ApplicationController


  def index
    render 'tags/index'
  end

  def show
    @tag = Tag.find_by(id: params[:id])
    render 'tags/show'
  end

end
