# Neocitizen

**Neocitizen** is composed of two parts:

1. A Ruby wrapper for the Neocities API, and
2. A tool to create and publish Neocities sites from the command line.

## Installation

```
gem install neocitizen
```

## Usage

### Creating a new site with the `neocitizen` tool

Run `neocitizen SITENAME` to generate a skeleton for a new site. That gives you a directory structure like this:

```
my-cool-site
├── .gitignore
├── Gemfile
├── Gemfile.lock
├── Rakefile
└── content
    └── index.html
```

The `content` directory will contain all the files the will be uploaded to your site. Neocitizen will use Git to determine what files should be uploaded in order to minimize bandwidth usage.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/neocitizen/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Authors

Neocitizen is made by [@aergonaut](https://github.com/aergonaut).

## License

The MIT License (MIT)

Copyright (c) 2014 Chris Fung

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
