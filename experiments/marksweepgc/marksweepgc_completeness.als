module examples/systems/marksweepgc


/*
 * Model of mark and sweep garbage collection.
 */


/**
 * The model has the following interesting constructs:
 *  -- relation multiplicity keywords 
 *  -- relations with arities higher than 2
 *  -- various transitive closures and reflexive transitive closures applied to parameterized relational expressions
 *  -- nested join expressions involving transitive closure
 *  -- quantifiers
 *
 * This model contains 3 unsatisfiable assertions. 
 */


// a node in the heap
sig Node {}

sig HeapState {
  left, right : Node -> lone Node,
  marked : set Node,
  freeList : lone Node
}

pred clearMarks[hs, hs' : HeapState] {
  // clear marked set
  no hs'.marked
  // left and right fields are unchanged
  hs'.left = hs.left
  hs'.right = hs.right
}

// simulate the recursion of the mark() function using transitive closure
fun reachable[hs: HeapState, n: Node] : set Node {
  n + n.^(hs.left + hs.right)
}

pred mark[hs: HeapState, from : Node, hs': HeapState] {
  hs'.marked = hs.reachable[from]
  hs'.left = hs.left
  hs'.right = hs.right
}

// complete hack to simulate behavior of code to set freeList
pred setFreeList[hs, hs': HeapState] {
  // especially hackish
  hs'.freeList.*(hs'.left) in (Node - hs.marked)
  all n: Node |
    (n !in hs.marked) => {
      no hs'.right[n]
      hs'.left[n] in (hs'.freeList.*(hs'.left))
      n in hs'.freeList.*(hs'.left)
    } else {
      hs'.left[n] = hs.left[n]
      hs'.right[n] = hs.right[n]
    }
  hs'.marked = hs.marked
}

pred GC[hs: HeapState, root : Node, hs': HeapState] {
  some hs1, hs2: HeapState |
    hs.clearMarks[hs1] && hs1.mark[root, hs2] && hs2.setFreeList[hs']
}



assert Completeness {
  all h, h' : HeapState, root : Node |
    h.GC[root, h'] =>
      (Node - h'.reachable[root]) in h'.reachable[h'.freeList]
}
check Completeness for 10
