class BeerClub < ApplicationRecord
  has_many :applications, -> { where confirmed: [false, nil] }, class_name: "Membership", dependent: :destroy
  has_many :applicants, through: :applications, source: :user
  has_many :memberships, -> { where confirmed: true }, dependent: :destroy
  has_many :users, through: :memberships

  def to_s
    name
  end
end
