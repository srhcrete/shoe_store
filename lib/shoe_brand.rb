class ShoeBrand < ActiveRecord::Base
  has_many :matches
  has_many :shoe_stores, through: :matches
  validates(:title, {:presence => true, :length => {:maximum => 40}})
  validates(:title, uniqueness: { case_sensitive: false })
  before_save(:upcase_title)

  private

  def upcase_title
    array = self.title.split
    array.each do |t|
      t.capitalize!
    end
    self.title = array.join(' ')
  end
end
