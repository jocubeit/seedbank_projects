# Seedbank Projects

A project exhibiting Seedbank Issue #8.

After careful examination I have determined it's a load order issue, and that several gems cause the problem. What these gems have in common I'm not certain but it's most likely something to do with Rake::Task being extended.

Prepare the database:

``` bash
$ bundle
$ rake db:create && rake db:migrate && rake db:seed:development
```

## To replicate issue:

Uncomment any of the gems between `seedbank` and `jquery-rails`:

``` ruby
source 'https://rubygems.org'

gem 'rails', '3.2.6'
gem 'sqlite3'
gem 'thin'
gem 'jquery-rails'

# Loading any of the gems before seedbank, big issue:
#gem 'pg_search'
#gem 'periscope-activerecord'
#gem 'ancestry'
gem 'client_side_validations'

gem 'seedbank'

# Loading any of these gems after seedbank, no issues:
#gem 'pg_search'
#gem 'periscope-activerecord'
#gem 'ancestry'
#gem 'client_side_validations'


group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
```
  
Call bundle, invoke the `rails console`, and try to instantiate a new `Task` object:

``` bash
$ rails c

Loading development environment (Rails 3.2.6)

irb(main):001:0> Task.new
WARNING: Deprecated reference to top-level constant 'Task' found at: 
    Use --classic-namespace on rake command
    or 'require "rake/classic_namespace"' in Rakefile
ArgumentError: wrong number of arguments (0 for 2)
  from /Users/Dom/.rbenv/versions/1.9.3-p194/lib/ruby/gems/1.9.1/gems/rake-0.9.2.2/lib/rake/task.rb:71:in `initialize'
  from (irb):1:in `new'
  from (irb):1
  from /Users/Dom/.rbenv/versions/1.9.3-p194/lib/ruby/gems/1.9.1/gems/railties-3.2.6/lib/rails/commands/console.rb:47:in `start'
  from /Users/Dom/.rbenv/versions/1.9.3-p194/lib/ruby/gems/1.9.1/gems/railties-3.2.6/lib/rails/commands/console.rb:8:in `start'
  from /Users/Dom/.rbenv/versions/1.9.3-p194/lib/ruby/gems/1.9.1/gems/railties-3.2.6/lib/rails/commands.rb:41:in `<top (required)>'
  from script/rails:6:in `require'
  from script/rails:6:in `<main>'
irb(main):002:0> quit
```

## To remove the issue:

Comment out all of the gems between `seedbank` and `jquery-rails`:
  
``` ruby
source 'https://rubygems.org'

gem 'rails', '3.2.6'
gem 'sqlite3'
gem 'thin'
gem 'jquery-rails'

# Loading any of the gems before seedbank, big issue:
#gem 'pg_search'
#gem 'periscope-activerecord'
#gem 'ancestry'
#gem 'client_side_validations'

gem 'seedbank'

# Loading any of these gems after seedbank, no issues:
#gem 'pg_search'
#gem 'periscope-activerecord'
#gem 'ancestry'
gem 'client_side_validations'


group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
```
  
Call bundle, invoke the `rails console`, and try to instantiate a new `Task` object:

``` bash
$ rails c

Loading development environment (Rails 3.2.6)
irb(main):001:0> Task.new
=> #<Task id: nil, name: nil, project_id: nil, created_at: nil, updated_at: nil>
irb(main):002:0> quit
```
