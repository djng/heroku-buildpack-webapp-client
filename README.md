Web Application Buildpack [![Build Status](https://travis-ci.org/djng/heroku-buildpack-webapp-client.svg)](https://travis-ci.org/djng/heroku-buildpack-webapp-client)
=========================

This is a [Heroku buildpack](http://devcenter.heroku.com/articles/buildpacks) for your grunt based web application located in the `client` directory of your project. It installs npm and bower dependencies, runs grunt and supports compass.

The buildpack runs if it finds a `client` directory containing a gruntfile (`grunt.js`, `Gruntfile.js` or `Gruntfile.coffee`).
Your gruntfile must provide a `build` task and build the client into a `client/dist` folder.

Your server buildpack can then collect and serve the assets from `client/dist`.

How to use
----------

This is _not_ a standalone buildpack. It builds the client part of your web application and should be used together with other buildpacks like
[heroku-buildpack-ruby](https://github.com/heroku/heroku-buildpack-ruby) or [heroku-buildpack-python](https://github.com/heroku/heroku-buildpack-python).
Use [heroku-buildpack-multi](https://github.com/heroku/heroku-buildpack-multi) to run multiple buildpacks:

    $ heroku config:add BUILDPACK_URL=https://github.com/heroku/heroku-buildpack-multi.git

From here you will need to create a `.buildpacks` file which contains the buildpacks you wish to run when you deploy:

    $ cat .buildpacks
    https://github.com/djng/heroku-buildpack-webapp-client.git
    <YOUR BUILDPACK> [i.e. https://github.com/heroku/heroku-buildpack-ruby.git, https://github.com/heroku/heroku-buildpack-python.git, ...]

How it Works
------------

Here's an overview of what this buildpack does:

- Almost everything<sup>[[1]](#bpnchg)</sup> that [heroku-buildpack-nodejs](https://github.com/heroku/heroku-buildpack-nodejs) does (mainly installs node and npm and runs `npm install`).
- Installs grunt and compass.
- Installs bower if `client/bower.json` is available and runs `bower install`
- Runs `grunt build`.
- Removes everything except the `client/dist` folder.


For more technical details, see the [heavily-commented compile script](https://github.com/djng/heroku-buildpack-webapp-client/blob/master/bin/compile).

<sup><a name="bpnchg">[1]</a></sup> The following changes are made compared to [heroku-buildpack-nodejs](https://github.com/heroku/heroku-buildpack-nodejs):

- Does not automatically creates a [Procfile](https://devcenter.heroku.com/articles/procfile).
- Ignores `NODE_ENV` and install `devDependencies`.
- Installs the 'next' version of npm.

Testing
-------

[Anvil](https://github.com/ddollar/anvil) is a generic build server for Heroku.

```
gem install anvil-cli
```

The [heroku-anvil CLI plugin](https://github.com/ddollar/heroku-anvil) is a wrapper for anvil.

```
heroku plugins:install https://github.com/ddollar/heroku-anvil
```

The [ddollar/test](https://github.com/ddollar/buildpack-test) buildpack runs `bin/test` on your app/buildpack.

```
heroku build -b ddollar/test # -b can also point to a local directory
```

For more info on testing, see [Best Practices for Testing Buildpacks](https://discussion.heroku.com/t/best-practices-for-testing-buildpacks/294) on the Heroku discussion forum.
