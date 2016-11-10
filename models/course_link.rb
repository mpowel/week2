class CourseLink < ActiveRecord::Base
  
  belongs to :weeks #, dependent: :destroy
  
  validates_presence_of :title


end
