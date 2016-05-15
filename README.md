My attempt to solve [http://cryptopals.com/](the matsano crypto challenges).

# Things I have learnt about whilst doing this

* Ruby.
  * [https://www.practicingruby.com/articles/uses-for-modules-1](Modules) as an
  alternative to inheritance or object composition.
* Delving into the basics of crypto.
* Using TDD to drive the design of my program.
  * So far the main benefit I have got from TDD is to ensure correctness and produce an
  automated regression suite. This is due to, at work, there being a strong existing
  structure suggested by the ports and adapters architecture. The tests are at the
  port level where the interface is a command and therefore do nothing to drive
  the design inside the command handler (apart from respecting other port boundaries).
  * Since for this I am essentially producing a library (the code in src/) and a
  client of the library (the code in challenge_scripts/) the tests also help
  improve the design of the library API.
* Different flavours of OO.
  * The dynamic nature of Ruby has helped me try and think of the code from a
  message passing point of view and also to conceptually separate objects and
  classes a bit more.
  * Immutability and OO leads me towards either classes with just static methods,
  which seems more functional than OO, or towards classes where the data is
  passed in via the constructor.
  * Learning about [http://www.sitepoint.com/dci-the-evolution-of-the-object-oriented-paradigm/](data context interaction)
  and how it makes object collaboration a priority. I like how it makes the system
  use cases explicit (similar to BDD style testing), but not sure if this code is
  complicated enough to warrant this yet.
    * Seems to be a somewhat similar to domain services in DDD
