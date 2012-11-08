 /*
 * This space was intentionally left blank to preserve  
 * references to line numbers in accompanying texts.
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 */
 
module examples/case_studies/com


/*
 * Model of Microsoft Component Object Model (COM) query
 * interface and aggregation mechanism.
 *
 * For a detailed description, see:
 *   http://sdg.lcs.mit.edu/~dnj/publications/com-fse00.pdf
 *
 * author: Daniel Jackson
 */

sig IID {}

sig Interface {
  qi : IID -> lone Interface,
  iids : set IID,
  // next two lines should use domain() or range() functions
  iidsKnown : IID,
  reaches : Interface
}

fact {
  all i: Interface |
     (i.iidsKnown = i.qi.Interface) and
     (i.reaches = IID.(i.qi))
}

sig Component {
  interfaces : set Interface,
  iids : set IID,   // can't do iids = interfaces.Interface$iids
  first, identity : interfaces,
  eqs: set Component,
  aggregates : set Component
}

fact defineEqs {
  all c1, c2: Component |
    c1->c2 in eqs <=> c1.identity = c2.identity
}

fact IdentityAxiom {
  some unknown : IID | all c : Component |
    all i : c.interfaces | unknown.(i.qi) = c.identity
}

fact ComponentProps {
  all c : Component {
    c.iids = c.interfaces.iids
    all i : c.interfaces | all x : IID | x.(i.qi) in c.interfaces
  }
}

sig LegalInterface extends Interface { }
fact { all i : LegalInterface | all x : i.iidsKnown | x in x.(i.qi).iids}

sig LegalComponent extends Component { }
fact { LegalComponent.interfaces in LegalInterface }

fact Reflexivity { all i : LegalInterface | i.iids in i.iidsKnown }
fact Symmetry { all i, j : LegalInterface | j in i.reaches => i.iids in j.iidsKnown }
fact Transitivity { all i, j : LegalInterface | j in i.reaches => j.iidsKnown in i.iidsKnown }


fact Aggregation {
    no c : Component | c in c.^aggregates
    all outer : Component | all inner : outer.aggregates |
      (some inner.interfaces & outer.interfaces)
      && (some o: outer.interfaces | all i: inner.interfaces - inner.first | all x: Component  | (x.iids).(i.qi) = (x.iids).(o.qi))
    }
	
// full proof outline: ((((A2 und 14) <=> 42) und 45 ) => 43) <=> 44 ? 38	
//fact lemma45 { all c: Component| all i:c.interfaces | i.iids in c.interfaces.iids // 45 (valid) }
//fact lemma43 { not some c: LegalComponent | some i: c.interfaces | i.iids not in i.iidsKnown // 43' (valid)}
// fact lemma44 { all i: LegalInterface | i.iids in i.iidsKnown // 44' = not 44 (valid) 
// }

// fact lemma45 { all c: Component| all i:c.interfaces | i.iids in c.interfaces.iids } // gen�gt nicht
-- aus A2 mit 14 (gdw):
// fact not42 { not some c: LegalComponent | some i: c.interfaces | c.interfaces.iids not in i.iidsKnown } // is enough!
// fact not42 { all c: LegalComponent | all i: c.interfaces | c.interfaces.iids in i.iidsKnown } //  also enough!
fact step42 { some c: LegalComponent | some i: c.interfaces | c.interfaces.iids not in i.iidsKnown } // not enough
-- aus 42 ergibt sich, wegen 45 insbesondere ((((A2 und 14) <=> 42) und 45 ) => 43):
// fact not43 { not some c: LegalComponent | some i: c.interfaces | i.iids not in i.iidsKnown } 
// fact step43 { some c: LegalComponent | some i: c.interfaces | i.iids not in i.iidsKnown }
-- aus 43 ergibt sich, wegen (c.interfaces in LegalInterface) ganz allgemein (gdw): ((((A2 und 14) <=> 42) und 45 ) => 43) <=> 44 ? 38
// fact not44 { not some i: LegalInterface | i.iids not in i.iidsKnown } // is enough!
// fact step44 { some i: LegalInterface | i.iids not in i.iidsKnown } 
-- reflexivity l.76
// step 38 fact Reflexivity { all i : LegalInterface | i.iids in i.iidsKnown }

assert Theorem1 {
	// A2:
	all c: LegalComponent | all i: c.interfaces | c.iids in i.iidsKnown // 78 sec
	
	/* original check 
	all c: LegalComponent | all i: c.interfaces | c.iids = i.iidsKnown
	*/
}
check Theorem1 for 9

