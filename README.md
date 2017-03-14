# Fly Me To The Moon Workshop

[![Build Status](https://travis-ci.org/darwins-challenge/workshop.svg?branch=master)](https://travis-ci.org/darwins-challenge/workshop)

A repository gathering all the related files used during the Fly Me To The Moon workshop.

The entire repository is downloadable as a [resource][workshop]. Note that the
resource also has some extra files, downloaded when the resource is built. In
particular what is missing in this repository is the [book][].

## Note: if you're using this package without an internet connection

We've prepared a directory containing all cargo dependencies, which
will come in handy if you're using this workshop package in a situation
where internet connections are spotty or non-existent.

To use this setup, set `CARGO_HOME` before proceeding to the location
of the `cargo_home` directory in this package.

On Linux/macOS:

    export CARGO_HOME=/...where you've unpacked.../cargo_home

On Windows:

    set CARGO_HOME=C:\...where you've unpacked...\cargo_home

Afterwards, `cd` to the appropriate directory and run `cargo` as usual:

    cargo build ...
    cargo run ...

## Help, I haven't done Rust before!

We've got you covered!

Rust is a great language with a lot to offer. To do the exercises in this workshop,
you'll only need a small fraction of Rust's features.

We'll tell you all you need to know in the file called `help/FIRST_TIME_RUSTER.md`.

## Now what?

You can do any number of things!

- If you want to learn more about Genetic Programming from the very first
  beginnings, you can read the [book][].
- If you'd prefer to dive right in, and do one of the guided projects, do one of
  the Moon Lander Projects. They're described below.
- If you're done early, there are more space-related projects to do. For
  example, the Apollo Guidance Computer.
- If you get stuck, unwind! Play the `moonlander-game` directly, yourself,
  as a lowly human!

## Moon Lander Projects

The main attraction of this workshop is--of course--the moon lander project.
You'll evolve a program that can safely land a capsule on the surface of the
moon, without any explicit coding on your part!

We recommend you tackle these in order.

- The projects are described below, but more detailed information is available
  in `moonlander-ast/README.md`.
- If you get stuck or need hints, see the files in the `help` directory.

### Straight Landing, fixed height

The lander starts at a fixed height, without any rotation, and needs to
successfully land. To solve this scenario, it suffices to evaluate a `Condition`
program.

If the `Condition` evaluates to `true`, the lander will use its thrusters (the
command will be `Thrust`). If it doesn't, it won't (the command will be `Skip`).

Use the program `evolve_condition`, which will try to evolve a program of type
`Condition`.

You will work with `1_fixed_vertical_landing.toml`. You will need to change the
file `src/fitness.rs`. See the corresponding repository README, how to run these
examples.

### Straight landing, random height
The previous scenario evolved a program that started at a fixed position.
However, such a winning program might be overfitting to the problem. In this
scenario, the lander starts at a random height.

Does your model still evolve a successful solution?

You will work with `2_random_vertical_landing.toml`. You will need to change the
file `src/fitness.rs`. See the corresponding repository README, how to run these
examples.

### With a Twist

In the preceding project, the lander always started upright. In this
project, it will start at angle.

Using the `Condition`, we could evaluate one of two commands: `Thrust` or
`Skip`. Once the lander also needs to correct its attitude, those two
commands are no longer sufficient (check: can `evolve_condition` evolve
a winning solution to this scenario?)

Instead, we'll need a new type of AST node, to increase the range of
programs that we can express.

Can you invent and implement such an AST node? (Don't forget to make a new
example to evolve it, and don't forget to update the fitness function)

You will work with `3_fixed_rotated_landing.toml`. You will need to change the
file `src/fitness.rs` and add a file to `src/grammar/`. See the corresponding
repository README, how to run these examples.

## Apollo Guidance Computer

We will try to fit the series of points with a function. You find a skeleton
project in the `AGC` directory. See the AGC chapter in the accompanying book for
a description of the book.

## Alternatively: Bring your own

We would love to see this tool used to solve a problem that you have. There is a
skeleton project that will give you a running start. Other than that you are on
your own.

[workshop]: https://s3.amazonaws.com/darwins-challenge/workshop.tar.gz
[book]: https://leanpub.com/flymetothemoon
