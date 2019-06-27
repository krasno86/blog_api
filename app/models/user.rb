# frozen_string_literal: true

class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?
  before_save :downcase_email

  def set_default_role
    self.role ||= :user
  end

  has_many :tasks, dependent: :destroy

  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  private

  def downcase_email
    self.email = self.email.delete(' ').downcase
  end
end
