module examples/algorithms/dijkstra

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

check DijkstraPreventsDeadlocks for 1 State, 1 Process, 1 Mutex expect 0
