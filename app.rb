# require 'sinatra'
# require 'sqlite3'
# require 'active_support/all'
# require 'active_support/core'
# require 'json'
# require 'haml'
# require 'builder'

require 'sinatra'
#require 'sinatra/contrib'
require 'active_support/all'
#require 'active_support/core'
require 'sinatra/activerecord'
require 'sqlite3'
require 'rake'
require 'json'
require 'shotgun'
require 'haml'
require 'builder'

# require models 
require_relative './models/course_link'
require_relative './models/week'
#
# class MyApp < Sinatra::Base
#  register Sinatra::Contrib
#  register Sinatra::ActiveRecordExtension


# before do
#   content_type :json
# end

# enable sessions for this project

enable :sessions

set :database, "sqlite3:db/my_database.db"


# curl -X PUT -F 'week_id=31' http://localhost:9393/week/31

put '/week/:id' do
  link = CourseLink.where(id: params['id']).first

  if link
    link.week_id = params['id'] if params.has_key?('id')

    if link.save
      link.to_json
    else
      halt 422, link.errors.full_messages.to_json
    end
  end
end

####################################

get '/week' do
  Week.all.to_json(include: :course_links)
end


get '/week/:id' do
  Week.where(id: params['id']).first.to_json(include: :course_links)
end

post '/week' do
  week = Week.new(params)

  if week.save
    week.to_json(include: :course_links)
  else
    halt 422, week.errors.full_messages.to_json
  end
end

# curl -X PUT -F 'topic=new' -F 'url=change' http://localhost:9393/week/32

put '/week/:id' do
  week = Week.where(id: params['id']).first

  if week
    week.topic = params['topic'] if params.has_key?('topic')

    if week.save
      week.to_json
    else
      halt 422, list.errors.full_messages.to_json
    end
  end
end

delete '/week/:id' do
  week = Week.where(id: params['id'])

  if week.destroy_all
    {success: "ok"}.to_json
  else
    halt 500
  end
end




####################################


get "/" do
  401
end

error 401 do 
  "Not allowed!!!"
end


# see: http://www.sinatrarb.com/contrib/respond_with.html

#curl -v -H "Accept: application/json, */*" http://localhost:9393/tasks


get '/course_links' do
  CourseLink.all.to_json
end


post '/course_links' do
  link = CourseLink.new(params)

  if link.save
    link.to_json
  else
    halt 422, link.errors.full_messages.to_json
  end
end

# curl -X PUT -F 'title=new' -F 'url=change' http://localhost:9393/course_links/13

get '/course_links/:id' do
  link = CourseLink.find(params[:id])
  return_string = "Here's the link you requested!<br/><br/> #{link.url}<br/>"

end

# curl -X PUT -F 'title=new' -F 'url=change' http://localhost:9393/course_links/13

put '/course_links/:id' do
  link = CourseLink.where(id: params['id']).first

  if link
    link.title = params['title'] if params.has_key?('title')
    link.url = params['id'] if params.has_key?('id')

    if link.save
      link.to_json
    else
      halt 422, link.errors.full_messages.to_json
    end
  end
end


delete '/course_links/:id' do
  link = CourseLink.where(id: params['id'])
 
  if link.destroy_all
    {success: "ok"}.to_json
  else
    halt 500
  end
end



get "/interesting_link" do

	link = CourseLink.all.sample
    
#  return_string = link.url
#  link.url
  return_string = "Try this link:   #{link.url}"
end




#--------------------------------------------------------------------------------------
##### PAST FAILED ATTEMPTS FOR INTERESTING LINKS (OO)  #####

#get "/interesting_link" do

  # get a random link  
   #CourseLink[rand(.length)].to_json
 #  link = CourseLink['url'].sample(1).first
   #link = CourseLink['url'].sample(1).first
#   return_string
#   return_string = "Try this link: #{link.url}<br/>"
#  link =  CourseLink.sample.to_json
#  link =  CourseLink.find(sample(1)).first
#  link = CourseLink.first
#  link = CourseLink[rand(CourseLink.length)]
  # get the last three links viewed 
  # viewed = last_three_views
  #
  # return_string = "Try this link: #{link}<br/>"
  # return_string += "<br/>Recently Viewed"
  # viewed.each_with_index do |view, index|
  #   return_string += "<br/>#{index+1}. #{view}"
  # end
  #
  # # add the link to the list of viewed
  # viewed link
  
  # display the links 
#  return_string = "Try this link: #{link.url}<br/>"
#end


#--------------------------------------------------------------------------------------




get '/tasks', :provides => [:html, :json, :xml] do
  
  #Task.all.to_json
  @tasks = Task.all
  #
  # respond_to do |f|
  #   f.xml { @tasks.to_xml }
  #   f.on( 'text/json' ) { @tasks.to_json }
  #   f.on( 'text/html' ) { "wooops" }
  #   f.on( 'application/json' ) { @tasks.to_json }
  #   #f.on('*/*') {  Task.all.map{ |t| t.to_s }.to_s }
  #   f.on('*/*') { haml :'tasks/index' }
  # end

  respond_to do |f|
      f.xml { @tasks.to_xml }
      f.on( 'text/json' ) { @tasks.to_json }
      #f.on( 'text/html' ) { "wooops" }
      f.on( 'application/json' ) { @tasks.to_json }
      #f.on('*/*') {  Task.all.map{ |t| t.to_s }.to_s }
      f.on('*/*') { haml :'tasks/index' }
    
  end
 
  #Task.all.each{ |t| t.name + "<br/>" }
end
 
get '/tasks/:id' do
  Task.where(id: params['id']).first.to_json
end
 
# curl -X POST -F 'name=test' -F 'list_id=1' http://localhost:9393/tasks
#
# post '/tasks' do
#   task = Task.new(params)
#
#   if task.save
#     task.to_json
#   else
#     halt 422, task.errors.full_messages.to_json
#   end
# end
 
# curl -X PUT -F 'name=updates' -F 'list_id=1' http://localhost:9393/tasks/1
 
# put '/tasks/:id' do
#   task = Task.where(id: params['id']).first
#
#   if task
#     task.name = params['name'] if params.has_key?('name')
#     task.is_completed = params['is_completed'] if params.has_key?('is_completed')
#
#     if task.save
#       task.to_json
#     else
#       halt 422, task.errors.full_messages.to_json
#     end
#   end
# end
 
# delete '/tasks/:id' do
#   task = Task.where(id: params['id'])
#
#   if task.destroy_all
#     {success: "ok"}.to_json
#   else
#     halt 500
#   end
# end




get '/lists' do
  List.all.to_json(include: :tasks)
end
 
get '/lists/:id' do
  List.where(id: params['id']).first.to_json(include: :tasks)
  
  # my_list = List.where(id: params['id']).first
  # my_list.tasks
  #
  # my_task = Task.where(id: params['id']).first
  # my_task.list
  
  
end
 
post '/lists' do
  list = List.new(params)
 
  if list.save
    list.to_json(include: :tasks)
  else
    halt 422, list.errors.full_messages.to_json
  end
end
 
put '/lists/:id' do
  list = List.where(id: params['id']).first
 
  if list
    list.name = params['name'] if params.has_key?('name')
 
    if list.save
      list.to_json
    else
      halt 422, list.errors.full_messages.to_json
    end
  end
end
 
delete '/lists/:id' do
  list = List.where(id: params['id'])
 
  if list.destroy_all
    {success: "ok"}.to_json
  else
    halt 500
  end
end

