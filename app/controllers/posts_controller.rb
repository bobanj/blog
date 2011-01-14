class PostsController < ApplicationController
  before_filter :require_user, :except => [:index, :show]
  
  # GET /posts
  def index
    conditions = {:page => params[:page], :per_page => POSTS_PER_PAGE, :order => 'posted_at DESC', :include => :tags}
    if !params[:tag].blank? && (tag = Tag.find_by_name(params[:tag]))
      posts = tag.posts
      @posts = posts.paginate(conditions)
      @title = "#{params[:tag].capitalize}"
      @keywords = posts.map(&:title).join(',')
    else
      @posts = Post.paginate(conditions)
      @title = "Home"
      @keywords = KEYWORDS
    end
    #@posts = Post.select("title, author, id, content, posted_at").includes('tags').order("posted_at DESC").limit(15).all
    
    respond_to do |format|
      format.html
      #format.xml { render :xml => @posts  }
      #format.json { render :json => @posts }
      format.rss { render :layout => false } #index.rss.builder
    end
  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.build
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  def create
    
    @post = Post.new(params[:post]) #Need this here just in-case saving the draft fails.
    
    if params[:save_post]
      @post.commentable = true
      @post.posted_at = Time.now
      @post.author = current_user.name

      #Save both HTML and Markdown
      @post.content = RDiscount.new(@post.markdown).to_html
      
      if @post.save
        redirect_to(@post, :notice => 'Post was successfully created.')
      else
        render :action => "new"
      end
    end
    
    if params[:save_draft]
      @draft = Draft.new(params[:post])
      
      @draft.author = current_user.name
      @draft.content = RDiscount.new(@draft.markdown).to_html
      
     if @draft.save
        redirect_to(drafts_url, :notice => 'Draft was successfully created.')
      else
        render :action => "new"
      end
    end
    
  end

  # PUT /posts/1
  def update
    @post = Post.find(params[:id])
    
    #Save both HTML and Markdown
    #Also use this method to toggle comments on and off
    #So, need to make sure :markdown attr is present so we know its an edit update
    if params[:post][:markdown]
      params[:post][:content]  = RDiscount.new(params[:post][:markdown]).to_html
    end

    if @post.update_attributes(params[:post])
      redirect_to(@post, :notice => 'Post was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /posts/1
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to(posts_url)
  end
end
