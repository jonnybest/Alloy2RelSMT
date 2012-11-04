module exploration/com1_minified

sig IID {}

sig Interface {
  qi : IID -> /* lone */ Interface,
  iids : set IID,
  iidsKnown : IID,
  reaches : Interface
}

fact { all i :Interface | 
							// intentionally left blank
  (i.reaches = IID.(i.qi))  //reaches = ran[qi]
}

sig Component {
  interfaces : set Interface,
  iids : set IID,
  identity : interfaces,
}

fact IdentityAxiom {
  some unknown : IID | all c : Component |
    all i : c.interfaces | unknown.(i.qi) = c.identity
}

fact ComponentProps {
  all c : Component | c.iids = c.interfaces.iids 
}

sig LegalInterface extends Interface { }
fact { all i : LegalInterface | all x : i.iidsKnown | x in x.(i.qi).iids}

sig LegalComponent extends Component { }
fact { LegalComponent.interfaces in LegalInterface }

fact Symmetry { all i, j : LegalInterface | j in i.reaches => i.iids in j.iidsKnown }

fact Reflexivity { all i : LegalInterface | i.iids in i.iidsKnown }
fact Transitivity { all i, j : LegalInterface | j in i.reaches => j.iidsKnown in i.iidsKnown }
//

fact previousStep {
    //not all c: LegalComponent | all i: c.interfaces | c.iids in i.iidsKnown // A
	some c: LegalComponent | some i: c.interfaces | c.interfaces.iids not in i.iidsKnown // step 42
}
assert step43 {
	some c: LegalComponent | some i: c.interfaces | i.iids not in i.iidsKnown // step 43 - solvable
	//not some i : LegalInterface | i.iids not in i.iidsKnown // step 44 solvable
}
check step43
