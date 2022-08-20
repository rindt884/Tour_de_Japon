class Public::HomesController < ApplicationController
    
    def top
      @posts = Post.where(customer_id: [current_customer.id, *current_customer.following_ids]).order(created_at: :desc).page(params[:page])
      @today = Date.today #今日の日付を取得
      @now = Time.now     #現在時刻を取得
    end
    
    def about
    end
    
    def index
      @posts = Post.all.order(created_at: :desc).page(params[:page])
      @today = Date.today #今日の日付を取得
      @now = Time.now     #現在時刻を取得
    end
    
end
