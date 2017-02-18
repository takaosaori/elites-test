class Tweet < ActiveRecord::Base
    belongs_to :user
    
    validates :content, presence: true, allow_blank: false, length: { maximum: 140 } 
end
