# Help, I haven't done Rust before!

No worries. This doc will tell you all you need to know. It DOES assume you have set up Rust already.  If you haven't,
see the doc labeled "_Help, I don't have Rust_". It also assumes you have a text editor that you're comfortable with
that can do Rust syntax highlighting. If you don't have a favorite editor yet, either [Atom](https://atom.io) or [Visual
Studio Code](https://code.visualstudio.com) are safe bets.

This doc is divided into three parts:

- Running the project.
- What you need to know for the first assignment: arithmetic, loops and accumulators.
- What you need to know for the second assignment: structs, traits, boxes.

## Running the project

Rust's main build tool is called *Cargo*, and everyone uses it because it's great! You'll use Cargo to automatically
download dependencies from the internet, build your executables, run your tests and run your program.

Cargo is run from the command line, so open a command-line or terminal window and `cd` to the directory where
you've unpacked the workshop.

Before we start, make sure you either have an internet connection, or have the `CARGO_HOME` environment variable set up
to point to the location where we've already downloaded all dependencies for you (see the `README.md` file in the parent
directory for more information on how to do that).

Afterwards, do:

    cd moonlander-ast

    # This runs the first scenario, storing the output in a file called output.json
    cargo run --release --example evolve_condition 1_fixed_vertical_landing.toml > output.json

(You can also read the README.md in the moonlander-ast directory for further guidance).

You've just run the code through the first moon lander scenario! To see how your moon lander did,
open `output.json` in the "Moonlander Visualizer":

    cd ../moonlander-visualisation
    cargo run ../moonlander-ast

Then open the following address in the browser:

    http://localhost:8080/

And open `output.json`.

It's best if you leave this program open in a different tab/command line window so you just have to rerun the simulator
to produce a new file and open it again from the web interface.

## First assignment: arithmetic


## Second assignment: structs
