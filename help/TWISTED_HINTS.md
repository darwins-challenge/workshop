Hints
=====

If you're stuck, here are some hints that should help you get back on track.

This document is divided into 2 parts: hints to get you thinking, and spoiler hints.

Have you considered...
----------------------

- We need a node that can decide between more than 2 alternatives.
- Different AST nodes can be combined to form all possible choices that we need.
- Don't forget to implement `EvaluateToCommand` for this new node type you've defined.
- Don't forget to update the fitness function to guide the genetic algorithm.

.

.

.

.

.

.

.

.

.

.

.

.

What we did
-----------

Actually we tried 3 different node types:

`Program`, such that:

    Program::If(condition, then, else)
    Program::Command(command)

To encode chained `if` statements,

`DecisionList`, such that:

    Vec<(Condition, Command)>

Implementing a sort of `switch/case` statement, yielding the first `Command` that corresponds to a true condition.

`DecisionChain`, such that:

    DecisionChain::Cond(condition, then, next)
    DecisionChain::Stop

Which is an pure enum-based variant of `DecisionList`.

The second seems to perform slightly better than the first, but could perform even better if we could splice two
`DecisionLists` together during crossover, which is currently not possible due to the framework.

The 3rd is a re-implementation of the 2nd in an 100% enum fashion, which due to its internal structure does allow
splicing lists together. However, this one has the downside that its depth grows uncontrollably during crossover, hence
slowing down the simulation and weighing the individuals down with lots of useless code.

We also give a small penalty for average rotation offset from 0 during the simulation, and a large penalty
for rotation offset at the end of the simulation.
