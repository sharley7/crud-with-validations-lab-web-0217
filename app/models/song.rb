class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: { scope: [:artist_name, :release_year],
    message: "An artist can only use each title once a year." }
  validates :artist_name, presence: true
  validates :released, inclusion: { in: [true, false] }

   with_options if: :released? do |release|
      release.validates :release_year, presence: true
      release.validates :release_year, numericality: {
      less_than_or_equal_to: Date.today.year }
    end


   def released?
     released
   end

end
