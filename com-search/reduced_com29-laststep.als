module examples/case_studies/test_com

sig IID {}

sig Interface {
  qi : IID -> Interface,
  iids : set IID,
  iidsKnown : IID
}

fact {
  all i: Interface | (i.iidsKnown = i.qi.Interface)
}

sig Component {
  interfaces : set Interface,
  iids : set IID,  
  first, identity : interfaces
}

fact IdentityAxiom {
  some unknown : IID | all c : Component | all i : c.interfaces | unknown.(i.qi) = c.identity
}

fact ComponentProps {
  all c : Component { c.iids = c.interfaces.iids }
}

sig LegalInterface extends Interface { }

sig LegalComponent extends Component { }
fact { LegalComponent.interfaces in LegalInterface }

//fact Reflexivity { all i : LegalInterface | i.iids in i.iidsKnown }

fact lemmas {
	some c: LegalComponent | some i: c.interfaces | c.iids not in i.iidsKnown //28
}

assert Theorem1 {
	not all c: LegalComponent | all i: c.interfaces | c.iids in i.iidsKnown    // still improvable
}
check Theorem1 for 19

// works in SMT! 