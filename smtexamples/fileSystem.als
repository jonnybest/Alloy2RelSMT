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
	//FSO = Root.*entries
	all o: FSO, d: Dir | o in d.entries => o.parent = d
}

//fact {
//	all o: FSO | o in File or o in Dir
//	all f: File | f in FSO
//	all d: Dir | d in FSO
//	entries = ~parent
//}

fact {
	// testfact 
}

assert oneParent {
	all o: FSO-Root | one o.parent
}
check oneParent for 5
