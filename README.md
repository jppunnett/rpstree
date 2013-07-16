# rpstree

Ruby Process Tree displays a process and its childern as a tree.

This application uses:

* [Methadone](https://github.com/davetron5000/methadone) library, by [David Bryant Copeland](http://www.naildrivin5.com/blog/2011/12/19/methadone-the-awesome-cli-library.html)
* [RubyTree](http://rubytree.rubyforge.org/)


## Usage

The following command dispays all top-level processes and their childeren:

	rpstree
  
If you know the process id you're lookiging for, you can use the following command to show that process:

	rpstree 1234

You can get help by running:

	rpstree --help
  

## Installation

Add this line to your application's Gemfile:

	gem 'rpstree'

And then execute:

	$ bundle

Or install it yourself as:

	$ gem install rpstree


  
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
