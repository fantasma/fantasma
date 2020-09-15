# Fantasma

Goal: A decentralized game/framework where players maintain their own long-term state (e.g., points or achievements) signed by a trusted authority who verifies updates on that data.
The idea is to remove the burden of storage from hosts of simple puzzle, incremental, or MMO games while also giving players more value from game data (e.g., they could create an exclusive "1000+ Sudoku wins" group).

To bring some formalism to this, the conditions for a player to accrue more points/achievements are encoded as puzzles.
The puzzles are temporal constraints on finite state machines, and finding a solution is a matter of adding transitions to those FSMs in a way that satisfies the constraints.
For example, Sudoku can be encoded as a 9x9 grid of FSMs, some of which only have 1 value, with a temporal constraint that "eventually no row, column, or sector has duplicate values".
