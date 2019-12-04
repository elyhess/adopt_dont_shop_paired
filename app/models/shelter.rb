class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets
  has_many :reviews

  def pet_count_label
    "(#{pets.count} Pet#{"s" if pets.count != 1})"
  end
end
