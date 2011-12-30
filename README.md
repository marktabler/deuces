The Deuces Project [![Build Status](https://secure.travis-ci.org/marktabler/deuces.png)](http://travis-ci.org/koraktor/deuces)
------------------

One day, I was thinking about the challenge of scoring a poker hand with wild cards, and when I sat down to puzzle out the problem it started blossoming into a whole program. I just let it blossom; it felt natural to express the solution as a program, and it felt natural to let the program be a complete entity and not a fragment.

The Solution
------------

This is a simple API for a video poker game that handles Deuces Wild, Joker Poker, and standard video poker. The core idea is that there is a [Deck](https://github.com/marktabler/deuces/blob/master/lib/deuces/deck.rb) object, made of [Card](https://github.com/marktabler/deuces/blob/master/lib/deuces/card.rb) objects, that can be dealt into a [Hand](https://github.com/marktabler/deuces/blob/master/lib/deuces/hand.rb) object - and the `Hand` responds to `#discard`, `#draw`, and `#score` requests via the [Scoring module](https://github.com/marktabler/deuces/blob/master/lib/deuces/scoring.rb). Further documentation is hosted at [RDoc.info](http://rubydoc.info/github/marktabler/deuces/master/frames).

I'm proud of this project because it's polished beyond just the code. The code itself is, I think, concise and efficient while being easy to read and maintain. It's namespaced, modularized, and well-documented. Finally, I took the time to learn some new GitHub hooks (RDoc and TravisCI). In short, I'm happy because this isn't a hobbyist's project - it's a journeyman's project.
