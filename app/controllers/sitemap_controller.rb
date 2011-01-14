class SitemapController < ApplicationController
  def index
    @posts = Post.all(:select => "title, id, updated_at", :order => "updated_at DESC", :limit => 50000)
    @tags = Tag.all(:select => "name, id, updated_at", :order => "updated_at DESC", :limit => 50000)
    render :layout => false
  end
end