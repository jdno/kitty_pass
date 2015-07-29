# KittyPass

[![Build Status](https://travis-ci.org/jdno/kitty_pass.svg?branch=master)](https://travis-ci.org/jdno/kitty_pass)

**KittyPass** is a little web-based password manager for [BlueCat Networks'](https://www.bluecatnetworks.com) DHCP/DNS
server. It is designed for teams that don't want to use a full-blown CMDB, but need to share passwords and other
important information about their servers.

## Requirements
 
- Ruby 2.x.x
- Web + application server for [Ruby on Rails](https://rubyonrails.org) (e.g.
[Phusion Passenger](http://https://www.phusionpassenger.com))
- MySQL database

## Installation

**KittyPass** comes with [Capistrano](http://capistranorb.com), which makes it really easy to deploy the application 
to your server. If you are already familiar with [Ruby on Rails](https://rubyonrails.org) deployments, this should be
pretty straight forward. Otherwise, we recommend you checkout any tutorial that explains how to deploy a
[Ruby on Rails](https://rubyonrails.org) application using the operating system and web server of your choosing.

### Clone repository

The first step is to clone the repository to your local machine:

    git clone https://github.com/jdno/kitty_pass.git

### Preparations

For the following files, templates are provided in the files' location. Look there for any files ending with `.example`.

On your local machine, create these files by copying & renaming the provided templates:

- _/config/deploy.rb_
- _/config/deploy/production.rb_

Copy the these files into [Capistrano's](http://capistranorb.com) shared folder on your server:

- _/config/application.yml_
- _/config/database.yml_

Change these files' configuration parameters to suite your needs.

### Deployment

After configuring [Capistrano's](http://capistranorb.com), run the following command:

    bundle exec cap production deploy
    
[Capistrano's](http://capistranorb.com) will now try to install and start the application. If an error occurs, check
the provided output for its reason.

### Create first user

On the server, start the _Rails Console_ with this command:

    RAILS_ENV=production bundle exec rails console
    
Now create your first user:

    > user = User.new(name: 'John Doe', email: 'john.doe@example.com', password: 'password', password_confirmation: 'password')
    > user.confirm
    > user.save!
    
With this user, you can log into the web interface and start using the application.

## Updates

Depending on your installation, you can either update the application with [Capistrano](http://capistranorb.com), or
manually. In both cases keep in mind that you may need to run migrations.

To update the application with [Capistrano](http://capistranorb.com), simply run the command

    bundle exec cap production deploy

## Support

If you encounter a bug or have a feature request, please open an issue on GitHub:

[https://github.com/jdno/kitty_pass](https://github.com/jdno/kitty_pass)

## Development

**KittyPass** is still in active development, and right now only available as a _beta version_! To protect yourself 
against accidental loss of data, e.g. due to a bug, please back up your database regularly.

### Versioning

This application tries to follow the guidelines of [semantic versioning](http://semver.org). Given the version number 
MAJOR.MINOR.PATCH, we increment the:

- MAJOR version when we make incompatible API changes,
- MINOR version when we add functionality in a backwards-compatible manner, and
- PATCH version when we make backwards-compatible bug fixes.

Please note that during development (i.e. versions 0.x.x), breaking changes can occur with ANY update! Only starting 
with version 1.x.x, the application's API should be considered stable.

# License

Copyright 2015 [jdno](https://github.com/jdno/)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
