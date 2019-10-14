class ArticleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :avatar

  belongs_to :user
end
