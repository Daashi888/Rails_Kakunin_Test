class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def index
    @blogs = Blog.all
    # binging.pry
    # raise
  end

  def new
    @blog = Blog.new #ビューにデータを渡す（インスタンス変数を定義する）
  end

  def create 
    # Blog.create(title: params[:blog][:title], content: params[:blog][:content])#Ruby on Rails 入門17
    # new_blog_pathというPrefixを書くことで、"/blogs/new"というURLの指定をします、という意味になる。
    # Blog.create(title: params.require(:blog).permit(:title, :content))#Ruby on Rails 入門18
    # Blog.create(blog_params)
    @blog = Blog.new(blog_params)
    if params[:back]
      render :new
    else
      if @blog.save
      #validateは、saveメソッド、createメソッド、updateメソッドなどデータを保存、更新する時に実行される。
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to blogs_path, notice: "ブログを作成しました！" #リダイレクトを行う
      else
      #入力フォームを再描画します。
      render :new
      # 処理終了後に呼び出されるビューがnew.html.erbに変更される
    end
  end
end


  def show
    # @blog = Blog.find(params[:id])
  end

  def edit
    # @blog = Blog.find(params[:id])
  end

  def update
    # @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "ブログを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    # @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice:"ブログを削除しました！"
  end

  def confirm
    @blog = Blog.new(blog_params)
    render :new if @blog.invalid?
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content)
  end

  # idをキーとして値を取得するメソッドを追加
  def set_blog
    @blog = Blog.find(params[:id])
  end
end
