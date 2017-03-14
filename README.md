# workshop[![Build Status](https://travis-ci.org/darwins-challenge/workshop.svg?branch=master)](https://travis-ci.org/darwins-challenge/workshop)
A repository gathering all the related files used during the Fly me to the Moon workshop.

The entire repository is downloadable as a [resource][workshop]. Note that the
resource also has some extra files, downloaded when the resource is build. In
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

You want to learn about genetic programming and found these files. Now what?
First of all, make sure to read the [book][]. It allows you to learn a little
bit of theory behind what we are going to do. It also has some pointers what to
do next.

Basically it consist of doing one of the following projects:

### Projects

For each of the following projects there is a corresponding repository. Make
sure to also look into the READMEs of those repositories.

Below you find the *project* - *repository* correspondence.

* **Straight Landing** `moonlander-ast`.
* **With a Twist** `moonlander-ast`.
* **AGC** `AGC`.
* **Bring your own** `bring-your-own`.

### Straight Landing

#### First scenario
The lander starts at a fixed height, without any rotation, and needs to
successfully land. To solve this scenario, it suffices to evaluate a `Condition`
program.

If the `Condition` evaluates to `true`, the lander will use its thrusters (the
command will be `Thrust`). If it doesn't, it won't (the command will be `Skip`).

Use the program `evolve_condition`, which will try to evolve a program of type
`Condition`.

You will work with `1a_fixed_vertical_landing.toml`. You will need to change the
file `src/fitness.rs`. See the corresponding repository README, how to run these
examples.

#### Second scenario
The previous scenario evolved a program that started at a fixed position.
However, such a winning program might be overfitting to the problem. In this
scenario, the lander starts at a random height.

Does your model still evolve a successful solution?

You will work with `1a_random_vertical_landing.toml`. You will need to change the
file `src/fitness.rs`. See the corresponding repository README, how to run these
examples.

### With a Twist

#### First scenario
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

You will work with `2a_fixed_rotated_landing.toml`. You will need to change the
file `src/fitness.rs` and add a file to `src/grammar/`. See the corresponding
repository README, how to run these examples.

### AGC

We will try to fit the series of points with a function. You find a skeleton
project in the `AGC` directory. See the AGC chapter in the accompanying book for
a description of the book.

### Bring your own

We would love to see this tool used to solve a problem that you have. There is a
skeleton project that will give you a running start. Other than that you are on
your own.

[workshop]: https://s3.amazonaws.com/darwins-challenge/workshop.tar.gz
[book]: https://leanpub.com/flymetothemoon
