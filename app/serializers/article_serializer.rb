class ArticleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description

  belongs_to :user
end
