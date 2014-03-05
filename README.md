# RailsAgnosticModels

The purpose of this project is to ease the pain of upgrading Rails versions by abstracting away differences between the Rails 2.3 and 3.2 API.

## Wait, if I'm gonna update my code, why don't I just update to Rails 3 instead of this crap?

If your codebase is small enough to do that in one go, please, by all means. 

However if you have a large legacy code base that you simply can't update all at once, this gem will (eventually) enable you to do small incremental changes and eventually make the jump without crashing and burning quite as bad.

## Installation

Add this line to your application's Gemfile:

    gem 'rails_agnostic_models'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_agnostic_models

## Usage

```ruby
class MyModel < ActiveRecord::Base
  version_agnostic_scope :active, { where active: true }    # proxys to named_scope in Rails 2, scope in Rails 3
  version_agnostic_inheritance_column "type_inheritance"    # set_inheritance_column in RAils 2, self.inheritance_column= in Rails 3
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
