class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :current_user
  before_action :authorized_user , only: %i[create destroy edit new ]
  before_action :allowed_user , only: %i[destroy update]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.user_id= @current_user.id
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def my_favourite
    user=User.find(@current_user.id)
    @favourites = user.favourite_articles

  end
  def add_favourite
    article=Article.find(params[:id])
    article.likers<<@current_user
    article.count+=1
    article.save
    redirect_to article_path
  end
  
  def remove_favourite
    article=Article.find(params[:id])
    article.likers.delete(@current_user)
    article.count-=1
    article.save
    redirect_to article_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content)
    end

    def authorized_user
      if @current_user.blank?
        redirect_to ('/signin')
      end
    end

    

    def allowed_user
      if @current_user.id != @article.user_id
         respond_to do |format|
          format.html {redirect_to articles_path, notice: 'You are not authorized' }
         end
      end
    end

end
