# FabLabs

[![Code Climate](https://codeclimate.com/github/fablabbcn/fablabs.png)](https://codeclimate.com/github/fablabbcn/fablabs) [![Build Status](https://travis-ci.org/fablabbcn/fablabs.png)](https://travis-ci.org/fablabbcn/fablabs) [![Test Coverage](https://codeclimate.com/github/fablabbcn/fablabs/badges/coverage.svg)](https://codeclimate.com/github/fablabbcn/fablabs/coverage)

## This is the official repository for fablabs.io platform project.

Fab labs provide widespread access to modern means for invention. They began as an outreach project from MIT’s Center for Bits and Atoms (CBA), and became into a collaborative and global network. You can find more information about Fab Labs on the [Fab Foundation Website](http://www.fabfoundation.org/).

If you are a Fab labs entusiast and/or you would like to contribute to the project please feel free to get in touch by [opening a new issue](https://github.com/fablabbcn/fablabs/issues/new).

## Running the project
 * Install node.js, npm, and bower
 * Use [rvm](https://rvm.io/), and set up Ruby to use the version specified in the Gemfile. 
 * Run `bundle install` to install all of the dependencies. Please don't use `bundle update`, as that will try to use the most recent versions of all packages, and that will break lots of dependencies. Note that there one of the dependencies might require packages outside of the Ruby ecosystem in order to install. Check out [this page](https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit#debian--ubuntu) to find out how to get those packages on your system. 
 * Not all of the javascript dependcies are listed in the gemfile, and are managed by [bower](http://blog.teamtreehouse.com/getting-started-bower) instead. Please install bower and install the depedencies that bower manages.
 * You need to set some environment variables in order to let the server run smoothly. If you don't want to be constantly resetting those variable, we recommend using the package [figaro](https://www.belighted.com/blog/figaro) in order to keep track of those things. The environment variables that you need to set are 'GEONAMES_USERNAME', 'DEV_DB_USERNAME', 'DEV_DB_PASSWORD', 'S3_BUCKET', 'S3_KEY', 'S3_SECRET', 'S3_REGION'
 * Run `rails server`

