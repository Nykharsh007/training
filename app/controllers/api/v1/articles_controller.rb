class Api::V1::ArticlesController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    articles=Article.all
    render jason: articles,status: 200
  end

  def show
    article=Article.find_by(id: params[:id])
    if article
      render jason: article, status:200
    else
      render jason: {
        error: "Article cannot be found"
      }
    end
  end

  def create
    article=Article.new(
      title:article_params[:title],
      body:article_params[:body],
      author:article_params[:author]
      )

    if article.save
      render jason: article, status:200
    else 
      render jason:{
        error: "Error Creating..."
      }
    end
  end

  def update
   article=Article.find_by(id: params[:id])
   if article
    article.update(title: params[:title],
      body: params[:body],
      author: params[:author])
    render jason: article, status:200
  else
    render jason: {
      error: "Article not found"
    }
  end
end

def destroy
  article=Article.find_by(id: params[:id])
  if article
    article.destroy
    render jason: "Article has been successfully deleted"
  else
    render jason: {
      error: "Article not found"
    }
  end
end

private
def article_params
  params.require(:article).permit(
    :title,
    :body,
    :author)
end
end
