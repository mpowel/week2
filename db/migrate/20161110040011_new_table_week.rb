class NewTableWeek < ActiveRecord::Migration[5.0]
  def change
    
    create_table :weeks do |t|
      
      t.text :topic
      t.datetime :beginning
      
  end
end
end