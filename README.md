# DBBinarySearch

![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)
[![CI Status](http://img.shields.io/travis/acrookston/db_binary_search.svg?style=flat)](https://travis-ci.org/acrookston/db_binary_search)
[![Code Climate](https://codeclimate.com/github/acrookston/db_binary_search/badges/gpa.svg)](https://codeclimate.com/github/acrookston/db_binary_search)
[![codecov](https://codecov.io/gh/acrookston/db_binary_search/branch/master/graph/badge.svg)](https://codecov.io/gh/acrookston/db_binary_search)


An Active Support concern extending Active Record with the ability to binary
search a table for use with non-indexed, sorted tables.

The gem allows you to avoid slow database scans if you have an
auto-incrementing primary key running in parallel with a column which
you want to search.

For example if you have a log table with a lot of records and it has the
typical rails setup with `id` and `created_at` columns. You want to locate
a specific date but the `created_at` column is not indexed, you can use
db_binary_search to locate a row based on `created_at` faster than letting
the database scan the entire column/table for the record.

Unlike a regular binary search algorithm which generally looks for an
exact value, this method will return the closest matching primary key.

## Prerequisites

This approach will only work if you have an automatically incrementing
(or similar) primary key column and a chronologically sorted column to search,
e.g. a rails created_at column which doesn't change.

## Installation

Add this line to your Gemfile:

```ruby
gem 'db_binary_search'
```

And then execute:

```
    $ bundle
```

Or install it yourself as:

```
    $ gem install db_binary_search
```

## Usage

First include the `DBBinarySearch` concern into your `ActiveRecord`
model, then call the `binary_search` class method to search for the id.

```
binary_search(column, value, lower_id=nil, upper_id=nil)
```

- `column` a symbol, is the table column to search for.
- `value` a comparable value of same type as `column`, the value you are searching for.
- `lower_id` optional primary key value to start searching lower bound at. Defaults to `model.first.id`.
- `upper_id` optional primary key value to start searching upper bound at. Defaults to `model.last.id`.

Full example:

```
class Log < ActiveRecord::Base
  include DBBinarySearch
end

id = Log.binary_search(:created_at, DateTime.parse("2017-01-07 00:00:00"))
# use id...
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/acrookston/db_binary_search.

If you're making a big change, please open an Issue first, so we can discuss. Otherwise:

- Fork it
- Run setup `bin/setup`
- Make your changes
- Run tests (`bundle exec rake spec`)
- Send me a pull request

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

