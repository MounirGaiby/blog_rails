# frozen_string_literal: true

# Controller that handles /BlogPost/ routes.
class BlogPostsController < ApplicationController
  before_action :set_blog_post, except: %i[index new create] # only: %i[show edit update destroy]
  before_action :check_if_user_signed_in, except: %i[index show]

  def index
    @blog_posts = user_signed_in? ? BlogPost.all : BlogPost.published

    @pagy, @blog_posts = pagy(@blog_posts)
  end

  def show; end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      redirect_to @blog_post
    else
      render :new
    end
  end

  def edit; end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :edit, status: unprocessable_entity
    end
  end

  def destroy
    @blog_post.destroy
    redirect_to root_path
  end

  def blog_post_params
    params.require(:blog_post).permit(:title, :content, :published_at)
  end

  def set_blog_post
    @blog_post = user_signed_in? ? BlogPost.all.find(params[:id]) : BlogPost.published.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def check_if_user_signed_in
    redirect_to new_user_session_path unless user_signed_in?
  end
end
