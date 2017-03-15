# Help, I haven't done Rust before!

No worries. This doc will tell you all you need to know. It DOES assume you have set up Rust already.  If you haven't,
see the doc labeled "_Help, I don't have Rust_". It also assumes you have a text editor that you're comfortable with
that can do Rust syntax highlighting. If you don't have a favorite editor yet, either [Atom](https://atom.io) or [Visual
Studio Code](https://code.visualstudio.com) are safe bets.

This doc is divided into three parts:

- Running the project.
- What you need to know for the first assignment: arithmetic, loops and accumulators.
- What you need to know for the second assignment: enums, macros, traits, pattern matching

## Running the project

Rust's main build tool is called **Cargo**, and everyone uses it because it's great! You'll use Cargo to automatically
download dependencies from the internet, build your executables, run your tests and run your program.

Cargo is run from the command line, so open a command-line or terminal window and `cd` to the directory where
you've unpacked the workshop.

Before we start, make sure you either have an internet connection, or have the
`CARGO_HOME` environment variable set up to point to the location where we've
already downloaded all dependencies for you (see the `README.md` file in the
parent directory for more information on how to do that).

### Running the simulation

Afterwards, do:

    cd moonlander-ast

    # This runs the first scenario, storing the output in a file called output.json
    cargo run --release --example evolve_condition 1_fixed_vertical_landing.toml > output.json

In Rust, it is usual to distribute example binaries along with libraries you
ship, to show other people how the library is supposed to be used. You run these
using the `--example` switch. `--release` does a release build, which takes
longer to compile but will be faster to run.

`evolve_condition` is the example program that we're running. It evolves a
"Condition", a genetic program that produces a True or False answer based on a
boolean expressiion, which indicates whether the lander should fire its
thrusters or not.

See the `README.md` in the moonlander-ast directory for further information on
the files.

### Looking at the result in the visualizer

You've just run the code through the first moon lander scenario! To see how your
moon lander did, open `output.json` in the "Moonlander Visualizer":

    cd ../moonlander-visualisation
    cargo run ../moonlander-ast

Then open the following address in the browser:

    http://localhost:8080/

And open `output.json`.

It's best if you leave this program open in a different tab/command line window
so you just have to rerun the simulator to produce a new file and open it again
from the web interface.

## First assignment: arithmetic

The first assignment entails changing the function `score_lander` which is
found in `src/fitness.rs`. This assignment is about calculations and
accumulating variables. It will be mostly familiar, but here are some
things to keep in mind:

**Rust is strict about mixing integers and floats.**

That means that an expression like `3.14 * 2` won't typecheck, as you're
mixing floats and integers. Keep all your numbers as floats, by writing
something like `2.0`.

**Should I use f32 or f64?**

Rust is also going to be strict about mixing 32-bits floats and 64-bits floats.
To make it easy on you, just declare everything as `Number`, which is
a typedef we've introduced throughout the simulation code, so all code uses
the same kinds of floats without having to think about it.

(It's an `f32`, for the record.)

**Variables default to immutable.**

If you want to make an accumulator, like this:

    let total = 0.0;
    for i in 0..10 {
        total += i as f32;
    }

That won't work, because `total` has been declared as immutable. To make
it mutable, add `mut` in the declaration:

    let mut total = 0.0;

**Rust is expression-oriented.**

Like Ruby, the last expression in a block (which can be a function, or an `if`
block, or just any scoping block) determines the value. You don't have to write
`return` if all you want to do is return the last value.

**In `if` and `while`, curlies are required but parens are optional.**

Yup.

    # Not this
    if (condition) do_something();

    # But this
    if condition { do_something(); }

To see what fields are available on the `sensor_data` struct, either look
at the source file (`moonlander-ast/src/sim/sensor_data.rs`) or the generated
API documentation.

## Second assignment: enums

In the second assignment, you'll extend the grammar of the genetic program,
so that different types of programs can be generated.

**Enums**

We'll use Rust's _enums_ to encode AST nodes. Enums describe one of multiple
values that a particular type can have, but in Rust, the different values can
also themselves carry additional data! For example, the following enum defines a
type that represents either an `i32`, or the absence of one:

    enum MaybeInt {
        Nothing,
        SomeInt(i32)
    }

The `SomeInt` variant carries the data along with its value, while the `Nothing`
indicates the absence of an integer value. You might recognize this type as the
`Option` type, and in fact Rust comes with a generic version of it called
`Option<T>`, with two variants: `Some(T)` and `None`.

**Pattern matching**

So, given that a value of `MaybeInt` can be of one of two types, how do
we distinguish between them? The answer is in _pattern matching_, with the
`match` keyword. In a function:

    fn maybe_print(x: MaybeInt) {
        match x {
            MaybeInt::SomeInt(i) => { println!("The value is {}", i); },
            MaybeInt::Nothing => {},
        }
    }

The `match` statement will check if you've covered all the possible variants of
`MaybeInt` in your patterns, and fail to compile if you've forgotten one.

**Recursive enums**

Let's say we wanted to define a linked list enum type:

    enum LinkedList {
        Done,
        Value(i32, LinkedList)
    }

A value of type `LinkedList` can be either an empty list (signified by `Done`),
or a single value followed by a linked list (you might recognize
this type from school ;)).

However, the definition as given will not work in Rust. But why?

In Rust, as in C++, objects are allocated on the stack, or in-place in a parent
object, unless indicated otherwise. So, how many bytes would a `LinkedList` type
as defined take up? How many bytes would you reserve on the stack, to hold the
return value of a function that would return a `LinkedList` instance, if you
didn't know in advance which variant you would get?

It would have to be the maximum of the sizes of all the individual variants, so
it could hold any variant.

So how many bytes does each variant need?

- Well, if it was the `Done` variant, it would take up 1 byte or so to indicate
  the type, and it didn't have any other data, so 1 byte.
- If it was the `Value` variant, it would take up 1 byte to indicate the type,
  another 4 bytes for the integer value, and however many bytes it would take to
  store a `LinkedList` type. But how many bytes is that?
    - Well, if the inner `LinkedList` is the `Done` variant. But if it was the
      other one, it would be 5 + however many bytes the inner-inner would take
      up. Etc.

So it turns out, this question is impossible to answer, and hence the type
cannot be _directly_ recursive like this. We need to go through some sort
of indirection that has a fixed size. In fact, we need to go through a pointer.

In Rust, the most common type of _owning_ pointer you'll see is a `Box<T>`. It's
very much like an `std::unique_ptr<T>` in C++, as in that it contains a pointer
to a dynamically allocated object on the heap, and it is guaranteed to be the
only `Box` pointing to that particular object. So if the Box goes out of scope,
the object on the heap can (and will) be freed.

So we would have to define our `LinkedList` type as follows:

    enum LinkedList {
        Done,
        Value(i32, Box<LinkedList>)
    }

And this _would_ successfully compile.

We'll use the same technique to define our AST nodes.

**Traits**

Rust's _Traits_ are like interfaces: they describe an API that a particular
object must implement. The main differences are:

- Traits can be implemented for _any_ type, not just structs/classes. So we can
  implement traits for enums, or even just plain old ints.
- Traits can be implemented _after the fact_. If some library gives you a type
  `Cat`, another library gives you `Snake`, and you want to implement a
  trait `Moulting` for both, you can.
- Some traits can be automatically implemented for you by the compiler. You
  _could_ implement these traits yourself if you wanted to, but the compiler
  can generate useful default implementations for them. Some such traits
  include:
    - `Debug`, makes a type debug-printable.
    - `RustcEncodable`/`RustcDecodable`, makes a type serializable to and from
      various serialization types such as JSON and XML.
    - `Clone`, makes a type copyable.
    - `PartialEq`, makes it possible to do equality checks on a type.

The trait you're going to have to implement for your new type is
the following one:

    pub trait EvaluateToCommand {
        fn evaluate(&self, sensor_data: &SensorData) -> Command;
    }

Which will take a node of your new type, and evaluate it to produce one of the
possible four commands (`Skip`, `Left`, `Right` or `Thrust`).

You implement a trait like this:

    impl EvaluateToCommand for MyType {
        fn evaluate(&self, sensor_data: &SensorData) -> Command {
            ...do something that returns a Command...
        }
    }

Note that `&self` is analogous to `this`: it is a pointer to the current
object. Similarly, `&SensorData` is a pointer to a `SensorData` object,
which contains the sensor data which is used to make decisions on.

**Macros**

Rust's compiler has _macros_. Macros take arguments and expand to Rust code.
This code is mixed into the actual code at compile time. As a result, you
can use macros to reduce repetition in your code.

We use a particular maco, called `impl_astnode!()`, that automatically generates
a bunch of repetetive code for you that allows the genetic programming engine
to manipulate the AST node and its children.

(If you're curious, the code generates implementations of two traits, `AstNode`
and `RandNode`, for the new node, each consisting of a bunch of pattern matching
statements with arms for each variant of the enum.)

**Putting it all together**

In the end, your new file is going to look something like this:

    #[derive(Debug,RustcDecodable,RustcEncodable,Clone,PartialEq)]
    pub enum MyNewNode {
        SomeCondition(Box<Condition>),
        TwoExpressionsMaybe(Box<Expression>, Box<Expression>),
        JustSomeNumber(Number)
    }

    impl_astnode!(MyNewNode, 4,
                int SomeCondition(cond),
                int TwoExpressionsMaybe(left, right),
                leaf JustSomeNumber(i));

    impl EvaluateToCommand for MyNewNode {
        fn evaluate(&self, sensor_data: &SensorData) -> Command {
            match *self {
                MyNewNode::SomeCondition(ref cond) => { ... },
                MyNewNode::TwoExpressionsMaybe(ref left, ref right) => { ... },
                MyNewNode::JustSomeNumber(i) => { ... }
            }
        }
    }

First, we'll define the new enum, and have the compiler derive some traits that
we need.

Then we'll have the `impl_astnode!()` macro implement two traits that the
genetic engine needs for AST manipulation. It doesn't matter what number you
pick in that definition, but it has to be unique among all node types. Any value
of 4 or higher is fine.  In the macro, the `int` or `leaf` qualifiers indicate
whether the indicated variants of the type would signify an _internal_ or a
_leaf_ node in the AST tree. These qualifiers are used to control the height of
the tree while generating random trees: as we go deeper into the tree, the
chances of generating internal nodes go down, so that we avoid generating
infinitely deep trees. The variable names inside the alternatives must be unique
per case, but their names don't really matter.

Finally, we implement the `EvaluateToCommand` trait, which is called by the
simulation engine, to turn the program into an action the moon lander is going
to take. This is where the meat of your program is going to go.

Add this code in a new file in the `src/grammar` directory, and don't forget
to add the file in `src/grammar/mod.rs` (just copy/paste the existing examples).

**Making a new example executable**

The final thing you'll have to do is copy `examples/evolve_condition.rs` to a
new file, and make it evaluate an AST that is rooted in your newly defined node
type. That basically comes down to copying the file and search-and-replacing the
type `Condition` with your new type name.
