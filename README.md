Neighborhood
==========

Neighborhood helps you easily add address fields and geocoding to your Rails
models.

It makes use of the [Geocoder gem](https://github.com/alexreisner/geocoder) for
all geocoding, although it handles some logic behind-the-scenes.

Installation
----------

This gem is meant to work with Ruby on Rails projects. I recommend you add it
to your project's Gemfile:

```ruby
gem 'neighborhood', '~> 0.1.0'
```

> **WARNING: Neighborhood will likely undergo major changes as I add more
> features over time. I highly recommend you limit the version in your
> `Gemfile` when installing Neighborhood (as shown above).**

Then install your bundle:

```text
$ bundle
```

Usage
----------

### Adding Fields to a Model

To add address fields to your model, run the generator:

```text
$ bundle exec rails g neighborhood [Model]
```

This adds the following fields:

* `street_address`
* `suite_apt`
* `city`
* `state`
* `zip`
* `country`
* `phone`
* `lat`
* `lng`
* `full_address`

Then migrate your database:

```text
$ bundle exec rake db:migrate
```

### Add Auto-Geocoding

To add automatic geocoding, add the `in_the_neighborhood` method to the model
to which you added the fields. For example, if you added these fields to a
`User` model, it might look like this:

```ruby
class User < ActiveRecord::Base
  in_the_neighborhood
end
```

> **WARNING: Neighborhood's `in_the_neighborhood` is tightly wound to the
> address fields. You need to make sure you've run the generator (and migrated)
> before you can mess with this method.

This method add an `after_validation` callback that will geocode the *address*
on the model. `address` is an instance method made available to you which
combines the individual address fields into one field.

When geocoding, Neighborhood automatically sets `lat`, `lng`, `full_address`
and `country`. Of course, you can still set country automatically, it just may
be overwritten.

> *Note: I know there's a lot missing here. I'm simply adding features and
> options as I need them. Feel free to contribute if you see something missing
> that you need.*

Contributing
----------

1. Fork it ( https://github.com/[my-github-username]/neighborhood/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
