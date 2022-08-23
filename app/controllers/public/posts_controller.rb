class Public::PostsController < ApplicationController
  
    before_action :correct_customer, only: [:edit, :update]
    
    def new
      @post = Post.new
    end
    
    def index
      @posts = Post.where.not(customer_id: [current_customer.id]).order(created_at: :desc).page(params[:page])
      @today = Date.today #今日の日付を取得
      @now = Time.now     #現在時刻を取得
    end
    
    def show
      @post = Post.find(params[:id])
      @customer = current_customer
      @comment = Comment.new
      @comments = Comment.all
      @today = Date.today #今日の日付を取得
      @now = Time.now     #現在時刻を取得
    end
    
    def edit
      @post = Post.find(params[:id])
    end
    
    def create
      @post = Post.new(post_params)
      @post.customer_id = current_customer.id
      if @post.save
        redirect_to public_post_path(@post), notice: "投稿しました！"
      else
        render :new
      end
    end
    
    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to public_posts_path
    end
    
    def update
      @post = Post.find(params[:id])
      if @post.update(post_params)
        redirect_to public_post_path(@post), notice: "更新しました！"
      else
        render :edit
      end
    end
    
    def search
      @posts = Post.all
      if params[:keyword].present?
        @posts = @posts.where('title LIKE (?) OR body LIKE (?)', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
        @keyword = params[:keyword]
      # else
        # redirect_to public_posts_path, notice: "キーワードが見つかりませんでした"
      end
      @posts = @posts.where(prefecture_id: params[:prefecture_id])
      # @posts = @post.page(params[:page])
      @today = Date.today #今日の日付を取得
      @now = Time.now     #現在時刻を取得
    end
    
    private
    
    def correct_customer
      @post = Post.find(params[:id])
      unless @post.customer == current_customer
        redirect_to public_post_path(@post)
      end
    end
    
    def post_params
      params.require(:post).permit(:customer_id, :title, :body, :rideday, :runtime, :mileage, :prefecture_id, :profile_image, images: [])
    end
    
end