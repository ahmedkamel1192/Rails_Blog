class Api::V1::ArticlesController < Api::V1::ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :favourites]
  before_action :allowed_user , only: %i[destroy update edit]
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
    render json: {data: @articles}
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    render json: {data: @article}
  end


  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.user_id= @current_user.id
   
      if @article.save
        render json: {data: @article , message: 'article is successfuly added'}
      else
        render json: { message: 'article is Unsuccessfuly added'}
      end
    
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
      if @article.update(article_params)
        render json: {data: @article , message: 'article is successfuly updated'}
      else
        render json: { message: 'article is Unsuccessfuly added'}

      end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    render json: { message: 'article is deleted successfuly added'}

  end
  
  def add_favourite
    @article.likers<<@current_user
    @article.count+=1
    @article.save
    redirect_back fallback_location: article_path , notice: "Article #{@article.title} successfully added to favourites."
  end
  
  def remove_favourite
    @article.likers.delete(@current_user)
    @article.count-=1
    @article.save
    redirect_back fallback_location: article_path , notice: "Article #{@article.title} successfully removed from favourites."
  end

  def favourites
    if @article.likers.include? @current_user
        @article.likers.delete(@current_user)
        @article.count-=1
        redirect_back fallback_location: article_path , notice: "Article #{@article.title} successfully removed from favourites."
    else
        @article.likers<<@current_user
        @article.count+=1
        @article.save
        redirect_back fallback_location: article_path , notice: "Article #{@article.title} successfully added to favourites."
    end
    @article.save  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.permit(:title, :content)
    end

  
    
    def allowed_user
      if @current_user.id != @article.user_id
        render json: { message: 'you are not authorized'}

      end
    end

end
