module examples/algorithms/dijkstra

/*
 * Models how mutexes are grabbed and released by processes, and
 * how Dijkstra's mutex ordering criterion can prevent deadlocks.
 *
 * For a detailed description, see:
 *   E. W. Dijkstra, Cooperating sequential processes. Technological
 *   University, Eindhoven, The Netherlands, September 1965.
 *   Reprinted in Programming Languages, F. Genuys, Ed., Academic
 *   Press, New York, 1968, 43-112.
 */


sig Process {}
sig Mutex {}

sig State { waits: Process -> Mutex }



pred Deadlock  {
         some Process
         some s: State | all p: Process | some p.(s.waits)
}

pred GrabbedInOrder  {
//
}

assert DijkstraPreventsDeadlocks {
   some Process && GrabbedInOrder => ! Deadlock
}


//run Deadlock for 3 expect 1
//run ShowDijkstra for 5 State, 2 Process, 2 Mutex expect 1
check DijkstraPreventsDeadlocks for 1 State, 1 Process, 1 Mutex expect 0

