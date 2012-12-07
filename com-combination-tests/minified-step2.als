module exploration/com1_minified_step2

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
fact assumptions {
	// blank
}
assert step2 {
	not some c: LegalComponent | some i: c.interfaces | (i.iidsKnown not in c.iids) or (c.iids not in i.iidsKnown) // step2
}
check step2