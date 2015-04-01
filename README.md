# KittyPass

**KittyPass** is a little web-based password manager for [BlueCat Networks'](https://www.bluecatnetworks.com) DHCP/DNS
server. It is designed for teams that don't want to use a full-blown CMDB, but need to share passwords and other
important information about their servers.

One speciality of **KittyPass** is its API, which enables other tools to update the data automatically.

# Usage

**KittyPass** is a [Ruby on Rails](https://rubyonrails.org) application, which can be customized to fit your needs.

## Customization

The best way to customize **KittyPass** is to fork the project, and periodically pull updates into your fork. This way,
you can customize the application to your hearts content, and still benefit from the updates to the origin.

In the code, important configuration parameters are marked with a ```# TODO``` tag. Search for it, and you will find all
places where customization is necessary or recommended.

To keep your secrets and keys private, this application relies heavily on environment variables. Depending on your
deployment, you either want to provide those environment variables, or overwrite the respective configuration files
during the deployment. Using [Capistrano](http://capistranorb.com), this would be done with shared configuration files.

## Installation

**KittyPass** has a dummy configuration for [Capistrano](http://capistranorb.com), which is set up to make use of
[.rbenv](http://rbenv.org) to select the right Ruby version. You do not have to use
[Capistrano](http://capistranorb.com), but we recommend it for most environments.

**Please note that we cannot help you with the installation of KittyPass. We try to provide as much instructions and
examples as we can, but we are simply not able to support every user individually.**

## Configuration

Most of **KittyPass'** configuration is done via environment variables. Here is a list of all the variables you should
set. If you do not want to use environment variables, the files are listed as well so you can overwrite them during
deployment:

- */config/database.yml*
    - KITTYPASS_DB_DATABASE
    - KITTYPASS_DB_USERNAME
    - KITTYPASS_DB_PASSWORD
- */config/secrets.yml*
    - SECRET_KEY_BASE

## Updates

Depending on your installation, you can either update the application with [Capistrano](http://capistranorb.com), or
manually. In both cases keep in mind that you may need to run migrations.

# Development

This still is a work-in-progress, and not yet stable. This is also true for the documentation, which will be extended
during development.

## Contribute

For all contributions, an issue must exist first. If you want to implement a new feature, please open an issue first to
discuss what you want to do and why. If your idea does not fit the vision for **KittyPass**, we reserve the right to
decline your change. So please, discuss it with us before doing any work that may not even be merged (you are free to
implement whatever feature your want in your own fork, though)!

If you want to fix a bug, check the issue tracker for open tasks or submit your own.

Contributions must go through GitHub's pull requests, so fork the project, implement your changes and open a pull
request.

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
