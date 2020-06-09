class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :supplier
  has_and_belongs_to_many :products
  validates :amount, :destination, :price, :payment, :approved_date, presence: true
end
