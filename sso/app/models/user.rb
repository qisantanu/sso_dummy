# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tokens

  def generate_tok(app_id)
    token = SecureRandom.hex
    t = self.tokens.find_or_initialize_by(app_id: app_id)
    t.token ||= token
    t.save
    t
  end
end
