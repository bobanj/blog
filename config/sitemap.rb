# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = HOME_PAGE

SitemapGenerator::Sitemap.add_links do |sitemap|
  posts = Post.all(:select => "title, id, updated_at", :order => "updated_at DESC", :limit => 50000)
  posts.each do |post|
    sitemap.add post_path(post), :priority => 0.7, :changefreq => "weekly",  :lastmod => post.updated_at
  end

  tags = Tag.all(:select => "name, id, updated_at", :order => "updated_at DESC", :limit => 50000)
  tags.each do |tag|
    sitemap.add tag_posts_path(tag), :priority => 0.5, :changefreq => "weekly",  :lastmod => tag.updated_at
  end
end