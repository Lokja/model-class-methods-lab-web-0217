class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications

  def self.sailors
    joins(:classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.catamaran_operators
    joins(:classifications).where(classifications: {name: "Catamaran"}).uniq
  end

  def self.talented_seamen
    mb = joins(:classifications).where(classifications: {name: "Motorboat"}).uniq
    sb = joins(:classifications).where(classifications: {name: "Sailboat"}).uniq
    joined = (mb & sb).map{|cap| cap.name}
    Captain.where(name: joined)
  end

  def self.non_sailors
    ns_names = (Captain.all - Captain.sailors).map{|cap| cap.name}
    Captain.where(name: ns_names)
  end

end
