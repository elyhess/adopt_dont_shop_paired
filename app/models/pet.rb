class Pet < ApplicationRecord
  validates_presence_of :name, :sex, :approx_age, :image_path, :description
  validates_inclusion_of :adoptable, :in => [true, false]
  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy
  has_many :applications, through: :pet_applications

  def self.favorited(favorites_list)
    find(favorites_list.ids)
  end

  def self.applied
    select(:name, :id).joins(:pet_applications).distinct
  end

  def self.approved
    applied.where('pet_applications.approved=true')
  end

  def adoptable_status
    adoptable ? "adoptable" : "pending"
  end

  def owner
    pet_applications.where(approved: true).first.application
  end
end
