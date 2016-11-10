CourseLink.destroy_all
CourseLink.create([{
    title: "Course Policies",
    url: "https://daraghbyrne.github.io/onlineprototypes2016/course/structure/policies/2016/01/07/course-policies/"
    week_id: 1
  },
  {
    title: "Course Slack",
    url: "https://onlineprototypes2016.slack.com/messages",
    week_id: 1
  
  }])
  

#p "Created #{CourseLink.count} course links"

Week.delete_all
Week.create!([{
    topic: "Week 1: Basics I: Building Basic Web Services",
    beginning: "Tues, 25 Oct 2016 12:00:00 EST"
  },
  {
    topic: "Week 2: Basics II: Working with and storing Data",
    beginning: "Tues, 01 Nov 2016 18:59:5 EST"
  },
  {
    topic: "Week 3: The Day the World Ended",
    beginning: "Tues, 08 Nov 2016 18:59:5 EST"
  
  }])
  
#p "Created #{Week.count} weeks"
