# RailsAgnosticModels

The purpose of this project is to ease the pain of upgrading Rails versions by abstracting away differences between the Rails 2.3 and 3.2 API.

## Installation

Add this line to your application's Gemfile:

    gem 'rails_agnostic_models'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_agnostic_models

## Usage

```
class MyModel < ActiveRecord::Base
  version_agnostic_scope :active, { where active: true }
  version_agnostic_inheritance_column "type_inheritance"
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
