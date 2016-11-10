class Week < ActiveRecord::Base
  
    validates_presence_of :topic
    
    has_many :course_links  #, dependent: :destroy

end
