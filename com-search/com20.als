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


		
fact lemmas {
	//all c: LegalComponent | all i: c.interfaces | i.iidsKnown in c.iids	 // proven
	//all c: LegalComponent | all i: c.interfaces | c.iids in i.iidsKnown    // unprovable
	//all c: LegalComponent | all i: c.interfaces | all o: i.iidsKnown | o in c.iids // 16
	//some c: LegalComponent | some i: c.interfaces | some o : c.iids | o not in i.iidsKnown // 17
	some c: LegalComponent | some i: c.interfaces | some o : c.iids | o not in i.qi.Interface // 19
	//20 {some c: LegalComponent | some i: c.interfaces | some o : c.iids | no o.(i.qi)}
	//21 {some c: LegalComponent | some i: c.interfaces | some o : c.iids | no o.(i.qi).iids}
	//22 {some c: LegalComponent | some i: c.interfaces | some o : c.iids | o not in o.(i.qi).iids}
	//24 {some c: LegalComponent | some i: c.interfaces | some o : c.interfaces.iids | o not in o.(i.qi).iids}
	//26 {some c: LegalComponent | some i: c.interfaces | some o : c.interfaces.iids | o not in i.iidsKnown}
	//26 {some c: LegalComponent | some i: c.interfaces | some o : c.iids | o not in i.iidsKnown}
}

assert Theorem1 {
    some c: LegalComponent | some i: c.interfaces | some o : c.iids | no o.(i.qi) // 20
		
		/* original check 
		// inprovable: all c: LegalComponent | all i: c.interfaces | c.iids in i.iidsKnown    // unprovable
		// proven // all c: LegalComponent | all i: c.interfaces | i.iidsKnown in c.iids		 // proven 
		*/
     }
check Theorem1 for 9

