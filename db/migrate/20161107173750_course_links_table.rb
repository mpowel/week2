class CourseLinksTable < ActiveRecord::Migration[5.0]
  def change
    
    create_table :course_links do |t|
    
          t.string :url    #will hold the link
          t.string :title   #will have some descriptive information about the link.   
          t.timestamps
    end
  end
end