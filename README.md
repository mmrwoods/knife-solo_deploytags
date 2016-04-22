# Knife Solo Deploy Tags

Adds git tags to help keep track of which version of the chef repo has been
"deployed" to which hosts using `knife solo cook`.

Currently uses a single tag per host, so you can `git show hostname` to see
what has been deployed to a host.

## Installation

Assuming you are using bundler, just add to Gemfile:

    gem 'knife-solo_hooks', github: 'thickpaddy/knife-solo_hooks'

If you are not using bundler, you know what you're doing, install the gem :-)

## Usage

Cook a node via knife solo:

    knife solo cook foo.bar.baz

Marvel at the addition of a git tag for the host:

    git show foo.bar.baz

Bleedin' magic, wha!

## Caveats

There are circunmstances whereby tagging the repo is not possible, for example
when there are local uncommitted changes. In these circumstances, no tags will
be created/udpated, a warning will be printed, but cooking the node will not be
prevented. Heed the warnings if you want to ensure the deploy tags are accurate.
