# Fly Me To The Moon Workshop

[![Build Status](https://travis-ci.org/darwins-challenge/workshop.svg?branch=master)](https://travis-ci.org/darwins-challenge/workshop)

This repository bundles all subrepositories for the Fly Me To The Moon workshop.

**If you're looking at this repository on GitHub:** you're missing some files.
Download the whole bundle as a [resource][workshop]. In particular, you're
missing the [book][].

**If you got these files from a USB stick during the workshop**: congratulations,
you're all set!

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
- If you get stuck, unwind! Play the `moonlander-game` directly, yourself (even
  if you're just a human).

## Moon Lander Projects

The main attraction of this workshop is--of course--the moon lander project.
You'll evolve a program that can safely land a capsule on the surface of the
moon, without any explicit coding on your part!

We recommend you tackle these projects in order.

- The projects are described in `moonlander-ast/README.md`.
- If you get stuck or need hints, see the files in the `help` directory.
- If you want to look up documentation on one of the Rust libraries used in this
  project, see the `doc` directory.

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
