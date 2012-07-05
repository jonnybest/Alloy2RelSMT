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

pred clearMarks[hs, hs_ : HeapState] {
  // clear marked set
  no hs_.marked
  // left and right fields are unchanged
  hs_.left = hs.left
  hs_.right = hs.right
}

// simulate the recursion of the mark() function using transitive closure
fun reachable[hs: HeapState, n: Node] : set Node {
  n + n.^(hs.left + hs.right)
}

pred mark[hs: HeapState, from : Node, hs_: HeapState] {
  hs_.marked = hs.reachable[from]
  hs_.left = hs.left
  hs_.right = hs.right
}

// complete hack to simulate behavior of code to set freeList
pred setFreeList[hs, hs_: HeapState] {
  // especially hackish
  hs_.freeList.*(hs_.left) in (Node - hs.marked)
  all n: Node |
    (n !in hs.marked) => {
      no hs_.right[n]
      hs_.left[n] in (hs_.freeList.*(hs_.left))
      n in hs_.freeList.*(hs_.left)
    } else {
      hs_.left[n] = hs.left[n]
      hs_.right[n] = hs.right[n]
    }
  hs_.marked = hs.marked
}

pred GC[hs: HeapState, root : Node, hs_: HeapState] {
  some hs1, hs2: HeapState |
    hs.clearMarks[hs1] && hs1.mark[root, hs2]  && hs2.setFreeList[hs_]
}

assert Soundness1 {
  //not(
  all h, h_ : HeapState, root : Node |
    h.GC[root, h_] =>
      (all live : h.reachable[root] | {
        h_.left[live] = h.left[live]
        h_.right[live] = h.right[live]
      })
   //)
}
check Soundness1 for 8 
