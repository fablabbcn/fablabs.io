# FabLabs

[![Code Climate](https://codeclimate.com/github/fablabbcn/fablabs.png)](https://codeclimate.com/github/fablabbcn/fablabs) [![Build Status](https://travis-ci.org/fablabbcn/fablabs.io.png)](https://travis-ci.org/fablabbcn/fablabs.io) [![Test Coverage](https://codeclimate.com/github/fablabbcn/fablabs/badges/coverage.svg)](https://codeclimate.com/github/fablabbcn/fablabs/coverage)

## This is the official repository for fablabs.io platform project.

Fab labs provide widespread access to modern means for invention. They began as an outreach project from MIT’s Center for Bits and Atoms (CBA), and became into a collaborative and global network. You can find more information about Fab Labs on the [Fab Foundation Website](http://www.fabfoundation.org/).

If you are a Fab labs entusiast and/or you would like to contribute to the project please feel free to get in touch by [opening a new issue](https://github.com/fablabbcn/fablabs/issues/new).


#### Getting started

1. `bower install`

1. `rails s`

1. Add this to your `/etc/hosts`:

    `127.0.0.1   www.fablabs.local`

1. Visit [http://www.fablabs.local:3000](http://www.fablabs.local:3000)

#### Tests

Run tests with:

`bundle exec rake`


#### Starting with docker-compose

1. Add all the secrets to an .env file


1. Start the project:  
`docker-compose up web app`

1. Create database (only the first time):  
`docker-compose exec app rake db:setup`

1. Add this to your `/etc/hosts`:

    `127.0.0.1   www.fablabs.local`

1. Visit [http://www.fablabs.local:3000](http://www.fablabs.local:3000)


#### Pull requests

All PRs are tested on Travis. Make sure the tests run fine.
