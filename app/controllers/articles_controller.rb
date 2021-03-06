class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_filter :check_permissions, :only => [:new, :create, :destroy, :edit, :update]

  respond_to :html, :json

  def index
    @articles = Article.all
    respond_with(@articles)
  end

  def show
    respond_with(@article)
  end

  def new
    @article = Article.new
    respond_with(@article)
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    @article.save
    respond_with(@article)
  end

  def update
    @article.update(article_params)
    respond_with(@article)
  end

  def destroy
    @article.destroy
    respond_with(@article)
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content, :bootsy_image_gallery_id)
    end

    def check_permissions
      authorize! [:update, :create, :delete], @article
    end
end
