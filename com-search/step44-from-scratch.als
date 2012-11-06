module exploration/com1_minified_VC

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

fact Lemma{
	// full proof outline: ((((A2 und 14) <=> 42) und 45 ) => 43) <=> 44 ϟ 38
	// this benchmark should show (44 ʌ ¬ VC) ϟ 38
	//	some i: LegalInterface | i.iids not in i.iidsKnown //44 	(unsat)
	not some i: LegalInterface | i.iids not in i.iidsKnown // 44' = not 44 (valid)
}

assert VC {
	all c: LegalComponent | all i: c.interfaces | c.iids in i.iidsKnown
}
check VC for 9
