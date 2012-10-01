abstract sig FSO {
	parent: lone Dir
}

sig File extends FSO {}
sig Dir extends FSO {
	entries: set FSO
}

sig Root extends Dir {}

fact {
	one Root
	no Root.parent

  FSO = Root + Root.^entries
  // FSO = Root.*entries 
  // FSO = Root + Root.entries
  all o: FSO, d: Dir | o in d.entries => o.parent = d

	entries = ~parent
}

assert oneParent {
	all o: FSO-Root | one o.parent
}
check oneParent for 8
