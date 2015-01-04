# spawnpoint

A minimalistic and opinionated starter template for your rails projects,
based on our experience and requirements at [Impraise](http://www.impraise.com)

## What's in the box?

- Rails 4.2.0, Spring (in development), Puma, Postgres
- Sass, Bourbon, Flutie, Haml
- Rspec, Timecop, FactoryGirl, SimpleCov
- Dotenv, an example .env file, and Dotenv-ready config files (`secrets.yml`, `database.yml`)
- Foreman and example Procfile

## Starting a new project with spawnpoint:

1. Start a new project, specifying a link to this template using the `-m` option

  ```shell
  $ rails new coolproject -m https://raw.github.com/impraise/spawnpoint/master/spawnpoint.rb
  ```

2. Grab a cup of coffee while everything is set up
3. You're good to go!

## Testing

(Temporary) - A `Makefile` is included with a simple shortcut to test the template
by creating a new project under `build/`, simply run:

```shell
$ make
```

## Credits

**spawnpoint** is developed and maintained by [Impraise](http://www.impraise.com).
Issue reports and pull requests are greatly appreciated!

![Impraise, inc](http://i.imgur.com/x2oFA91.png)
