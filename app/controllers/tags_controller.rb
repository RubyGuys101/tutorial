class TagsController < ApplicationController
  before_action :authenticate_author!

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def destroy
    @tag = Tag.find(params[:id])
    flash.notice = "Tag '#{@tag.name}' Destroy!"
    @tag.destroy

    redirect_to tags_path
  end
end
