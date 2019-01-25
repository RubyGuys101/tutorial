class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])

    @comment = Comment.new
    @comment.article_id = @article.id
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.save

    flash.notice = "Article '#{@article.title}' Create!"

    redirect_to article_path(@article)
  end

  def destroy
    # load article into @article
    @article = Article.find(params[:id])
    # destroy comments of @article
    @article.comments.destroy_all
    @article.taggings.destroy_all
    # set flash notice
    flash.notice = "Article '#{@article.title}' Destroy!"
    # destroy @article itself
    @article.destroy
    # redirect_to xxx
    redirect_to articles_path
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)

    flash.notice = "Article '#{@article.title}' Updated!"

    redirect_to article_path(@article)
  end

  def tag_list=(tags_string)

  end

  def article_params
    params.require(:article).permit(:title, :body, :tag_list, :image)
  end

end
