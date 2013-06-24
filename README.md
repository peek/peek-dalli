# Peek::Dalli

Take a peek into the Memcache commands made through Dalli during your application's requests.

Things this peek view provides:

- Total number of memcache commands called during the request
- The duration of the commands made during the request

## Installation

Add this line to your application's Gemfile:

    gem 'peek-dalli'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install peek-dalli

## Usage

Add the following to your `config/initializers/peek.rb`:

```ruby
Peek.into Peek::Views::Dalli
```

There is an additional JavaScript file peek-dalli provides that gives
additional information about the requests Dalli makes during the request:

- Reads
- Misses
- Writes

Include the `peek/views/dalli` JavaScript file in your application:

```coffeescript
#= require peek
#= require peek/views/dalli
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
