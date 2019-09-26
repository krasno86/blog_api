# frozen_string_literal: true

module Api::V1
  class ArticlesController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken
    include Serialize_object

    before_action :authenticate_user!
    before_action :set_article, only: [:show, :update, :destroy]

    def index
      @articles = @current_user.articles.all.order('created_at DESC')
      head(:not_found) if @articles.nil?
      render json: ArticleSerializer.new(@articles).serialized_json, status: 200
    end

    def show
      render json: ArticleSerializer.new(@article).serialized_json, status: 200
    end

    def create
      @article = @current_user.articles.new(article_params)
      if @article.save!
        render json: serialized_object(@article), status: 201
      else
        render json: @article.errors.messages, status: 422
      end
    end

    def update
      if @article.update(article_params)
        render json: serialized_object(@article)
      else
        render json: @article.errors, status: :unprocessable_entity
      end
    end

    def destroy
      if @article.destroy
        head :no_content, status: :ok
      else
        render json: @article.errors, status: :unprocessable_entity
      end
    end

    private

    def article_params
      params.require(:article).permit(:name, :description)
    end

    def set_article
      @article = @current_user.articles.find_by(id: params[:id])
      head(:not_found) if @article.nil?
    end
  end
end
