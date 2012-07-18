#after :projects do
  foo = Project.find_by_name("Foo")
  Task.create!(:name => "Bar", :project_id => foo.id) unless foo.nil?
#end
