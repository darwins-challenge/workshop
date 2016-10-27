Hints
=====

If you're stuck, here are some hints that should help you get back on track.

This document is divided into 2 parts: hints to get you thinking, and spoiler hints.

Have you considered...
----------------------

- Are you taking all variables into account? Also thinks like fuel, or the
  time that the moonlander manages to stay in the air?
- Even an end result that isn't perfect may be a stepping stone to success.

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

We incorporated the following into our fitness function:

- Gave a hefty success bonus for landing succesfully, obviously.
- Gave a small bonus for the number of frames that the moonlander managed to stay afloat.
  (surviving longer is better).
- Gave a small penalty for the average height (staying lower to the ground is better).
- Gave a bonus for fuel retained (less fuel used is better).
- Gave a bonus for hitting the ground, even if the lander crashed (hey, at least it's going
  in the right direction).
- Gave a penalty for program depth (a measure of complexity), thereby preferring smaller
  programs to larger programs that have the same score.
