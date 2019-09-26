# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true
  validates :description, presence: true

end
