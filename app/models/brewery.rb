class Brewery < ApplicationRecord
  validates :name, presence: true

  def self.all_in_ascending_order
    all.order(:name)
  end
end
