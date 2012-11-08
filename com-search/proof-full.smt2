; Zu beweisen: (all c: LegalComponent | all i: c.interfaces | i.iidsKnown = c.iids)
(assert 
 (! 
  (subset_2 interfaces (prod_1x1 Component Interface)) 
 :named a0 
 ) 
 )
(assert 
 (! 
  (subset_2 iids (prod_1x1 Component IID)) 
 :named a1 
 ) 
 )
(assert 
 (! 
  (subset_2 first (prod_1x1 Component Interface)) 
 :named a2 
 ) 
 )
(assert 
 (! 
  (subset_2 identity (prod_1x1 Component Interface)) 
 :named a3 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Component) (and (one_1 (join_1x2 (a2r_1 this) identity)) (and (one_1 (join_1x2 (a2r_1 this) first)) (and (subset_1 (join_1x2 (a2r_1 this) first) (join_1x2 (a2r_1 this) interfaces)) (subset_1 (join_1x2 (a2r_1 this) identity) (join_1x2 (a2r_1 this) interfaces))))))) 
 :named a4 
 ) 
 )
(assert 
 (! 
  (subset_2 eqs (prod_1x1 Component Component)) 
 :named a5 
 ) 
 )
(assert 
 (! 
  (subset_2 aggregates (prod_1x1 Component Component)) 
 :named a6 
 ) 
 )
(assert 
 (! 
  (subset_1 LegalComponent Component) 
 :named a7 
 ) 
 )
(assert 
 (! 
  (subset_1 LegalInterface Interface) 
 :named a8 
 ) 
 )
(assert 
 (! 
  (subset_3 qi (prod_2x1 (prod_1x1 Interface IID) Interface)) 
 :named a9 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Interface) (forall ((x0 Atom)) (=> (in_1 x0 IID) (lone_1 (join_1x2 (a2r_1 x0) (join_1x3 (a2r_1 this) qi))))))) 
 :named a10 
 ) 
 )
(assert 
 (! 
  (subset_2 iids1 (prod_1x1 Interface IID)) 
 :named a11 
 ) 
 )
(assert 
 (! 
  (subset_2 iidsKnown (prod_1x1 Interface IID)) 
 :named a12 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Interface) (one_1 (join_1x2 (a2r_1 this) iidsKnown)))) 
 :named a13 
 ) 
 )
(assert 
 (! 
  (subset_2 reaches (prod_1x1 Interface Interface)) 
 :named a14 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Interface) (one_1 (join_1x2 (a2r_1 this) reaches)))) 
 :named a15 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Component IID) 
 :named a16 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Component Interface) 
 :named a17 
 ) 
 )
(assert 
 (! 
  (disjoint_1 IID Interface) 
 :named a18 
 ) 
 )
(assert 
 (! 
  (forall ((i Atom)) (=> (in_1 i Interface) (and (= (join_1x2 (a2r_1 i) iidsKnown) (join_2x1 (join_1x3 (a2r_1 i) qi) Interface)) (= (join_1x2 (a2r_1 i) reaches) (join_1x2 IID (join_1x3 (a2r_1 i) qi)))))) 
 :named a19 
 ) 
 )
(assert 
 (! 
  (forall ((c1 Atom)(c2 Atom)) (=> (and (in_1 c1 Component) (in_1 c2 Component)) (= (subset_2 (prod_1x1 (a2r_1 c1) (a2r_1 c2)) eqs) (= (join_1x2 (a2r_1 c1) identity) (join_1x2 (a2r_1 c2) identity))))) 
 :named a20 
 ) 
 )
(assert 
 (! 
  (exists ((unknown Atom)) (and (in_1 unknown IID) (forall ((c Atom)) (=> (in_1 c Component) (forall ((i Atom)) (=> (and (in_1 i Interface) (in_1 i (join_1x2 (a2r_1 c) interfaces))) (= (join_1x2 (a2r_1 unknown) (join_1x3 (a2r_1 i) qi)) (join_1x2 (a2r_1 c) identity)))))))) 
 :named a21 
 ) 
 )
(assert 
 (! 
  (forall ((c Atom)) (=> (in_1 c Component) (and (= (join_1x2 (a2r_1 c) iids) (join_1x2 (join_1x2 (a2r_1 c) interfaces) iids1)) (forall ((i Atom)) (=> (and (in_1 i Interface) (in_1 i (join_1x2 (a2r_1 c) interfaces))) (forall ((x Atom)) (=> (in_1 x IID) (subset_1 (join_1x2 (a2r_1 x) (join_1x3 (a2r_1 i) qi)) (join_1x2 (a2r_1 c) interfaces))))))))) 
 :named a22 
 ) 
 )
(assert 
 (! 
  (forall ((i Atom)) (=> (in_1 i LegalInterface) (forall ((x Atom)) (=> (and (in_1 x IID) (in_1 x (join_1x2 (a2r_1 i) iidsKnown))) (in_1 x (join_1x2 (join_1x2 (a2r_1 x) (join_1x3 (a2r_1 i) qi)) iids1)))))) 
 :named a23 
 ) 
 )
(assert 
 (! 
  (subset_1 (join_1x2 LegalComponent interfaces) LegalInterface) 
 :named a24 
 ) 
 )
(assert 
 (! 
  (forall ((i Atom)) (=> (in_1 i LegalInterface) (subset_1 (join_1x2 (a2r_1 i) iids1) (join_1x2 (a2r_1 i) iidsKnown)))) 
 :named a25 
 ) 
 )
(assert 
 (! 
  (forall ((i Atom)(j Atom)) (=> (and (in_1 i LegalInterface) (in_1 j LegalInterface)) (=> (in_1 j (join_1x2 (a2r_1 i) reaches)) (subset_1 (join_1x2 (a2r_1 i) iids1) (join_1x2 (a2r_1 j) iidsKnown))))) 
 :named a26 
 ) 
 )
(assert 
 (! 
  (forall ((i Atom)(j Atom)) (=> (and (in_1 i LegalInterface) (in_1 j LegalInterface)) (=> (in_1 j (join_1x2 (a2r_1 i) reaches)) (subset_1 (join_1x2 (a2r_1 j) iidsKnown) (join_1x2 (a2r_1 i) iidsKnown))))) 
 :named a27 
 ) 
 )
; -- Annahme für Beweis durch Widerspruch:
; 1 (some c: LegalComponent | some i: c.interfaces | i.iidsKnown != c.iids)
; 2 (some c: LegalComponent | some i: c.interfaces | (i.iidsKnown not in c.iids) or (c.iids not in i.iidsKnown))
; 3 (some c: LegalComponent | some i: c.interfaces | (some o: i.iidsKnown | o not in c.iids) or (some o : c.iids | o not in i.iidsKnown))
; -- Fall 2: Annahme aus 2:
; A2 some c: LegalComponent | some i: c.interfaces | c.iids not in i.iidsKnown
; A2 not (all c: LegalComponent | all i: c.interfaces | c.iids not in i.iidsKnown)
(assert 
 (! 
  (not (and (forall ((c Atom)) (=> (in_1 c LegalComponent) (forall ((i Atom)) (=> (and (in_1 i Interface) (in_1 i (join_1x2 (a2r_1 c) interfaces))) (subset_1 (join_1x2 (a2r_1 c) iids) (join_1x2 (a2r_1 i) iidsKnown)))))) (forall ((c Atom)) (=> (in_1 c LegalComponent) (forall ((i Atom)) (=> (and (in_1 i Interface) (in_1 i (join_1x2 (a2r_1 c) interfaces))) (subset_1 (join_1x2 (a2r_1 i) iidsKnown) (join_1x2 (a2r_1 c) iids)))))))) 
 :named c0 
 ) 
 )
; -- proof outline: ((((A2 und 14) <=> 42) und 45 ) => 43) <=> 44 ? 38
; -- im Modell steht:
; 14 all c : Component | c.iids = (c.interfaces).iids -- line 65
(assert (!
(forall ((c Atom)) (=> (in_1 c Component) (= (join_1x2 (a2r_1 c) iids) (join_1x2 (join_1x2 (a2r_1 c) interfaces) iids1))))
:named a22))
; -- ganz allgemein gilt auch folgendes Lemma (obda):
; 45 all c: Component| all i:c.interfaces | i.iids in c.interfaces.iids
(assert 
 (! 
  (forall ((c Atom)) (=> (in_1 c Component) (forall ((i Atom)) (=> (and (in_1 i Interface) (in_1 i (join_1x2 (a2r_1 c) interfaces))) (subset_1 (join_1x2 (a2r_1 i) iids1) (join_1x2 (join_1x2 (a2r_1 c) interfaces) iids1)))))) 
 :named a29 
 ) 
 )
; -- aus A2 mit 14 (gdw):
; 42 some c: LegalComponent | some i: c.interfaces | c.interfaces.iids not in i.iidsKnown
; fact not42 { not some c: LegalComponent | some i: c.interfaces | c.interfaces.iids not in i.iidsKnown }
(assert 
 (! 
  (not (exists ((c Atom)) (and (in_1 c LegalComponent) (exists ((i Atom)) (and 
    (in_1 i Interface)
    (in_1 i (join_1x2 (a2r_1 c) interfaces))
    (not (subset_1 (join_1x2 (join_1x2 (a2r_1 c) interfaces) iids1) (join_1x2 (a2r_1 i) iidsKnown)))
  ))))) 
 :named a30 
 ) 
 )
; -- aus 42 ergibt sich, wegen 45 insbesondere ((((A2 und 14) <=> 42) und 45 ) => 43):
; 43 some c: LegalComponent | some i: c.interfaces | i.iids not in i.iidsKnown
; fact not43 { not some c: LegalComponent | some i: c.interfaces | i.iids not in i.iidsKnown }
(assert 
 (! 
  (not (exists ((c Atom)) (and (in_1 c LegalComponent) (exists ((i Atom)) (and 
    (in_1 i Interface)
    (in_1 i (join_1x2 (a2r_1 c) interfaces))
    (not (subset_1 (join_1x2 (a2r_1 i) iids1) (join_1x2 (a2r_1 i) iidsKnown)))
  ))))) 
 :named a31 
 ) 
 )
; -- aus 43 ergibt sich, wegen (c.interfaces in LegalInterface) ganz allgemein (gdw): ((((A2 und 14) <=> 42) und 45 ) => 43) <=> 44 ? 38
; 44 some i: LegalInterface | i.iids not in i.iidsKnown
; fact not44 { not some i: LegalInterface | i.iids not in i.iidsKnown }
(assert 
 (! 
  (not (exists ((i Atom)) (and (in_1 i LegalInterface) (not (subset_1 (join_1x2 (a2r_1 i) iids) (join_1x2 (a2r_1 i) iidsKnown)))))) 
 :named a32 
 ) 
 )
; -- reflexivity l.76
; 38 all i: LegalInterface | i.iids in i.iidsKnown
; -- 38 steht nun im Widerspruch zu 44. wzbw ?
; -- Fallunterscheidung: A1 (o in i.iidsKnown), A2 (o in c.iids)
; -- Fall 1: Annahme:
; A1 (some c: LegalComponent | some i: c.interfaces | (some o: i.iidsKnown | o not in c.iids)
; -- aus dem Modell:
; 6 fact { LegalComponent.interfaces in LegalInterface } -- line 74
; -- mit A1 und 6:
; 7 all c: LegalComponent | all i: c.interfaces | (i in LegalInterface)
; -- aus dem Modell:
; 8 fact { all i : LegalInterface | all x : i.iidsKnown | x in x.(i.qi).iids } -- line 71
; -- aus 8 mit A1 folgt:
; 9 (some c: LegalComponent | some i: c.interfaces | (some o: o.(i.qi).iids | o not in c.iids)
; -- aus dem Modell:
; 10 (all i : c.interfaces | all x : IID | x.(i.qi) in c.interfaces) -- line 66
; -- aus dem Modell:
; 11 sig Interface { iidsKnown : IID } -- line 35
; -- aus 11 mit 3 folgt:
; 12 all c: LegalComponent | all i : c.interfaces | all o : i.iidsKnown | (o in IID)
; -- mit 10 und 12 folgt aus 9:
; 13 (some c: LegalComponent | some i: c.interfaces | (some o: (c.interfaces).iids | o not in c.iids)
; -- aus dem Modell:
; 14 all c : Component | c.iids = c.interfaces.iids -- line 65
; -- aus 13 ergibt sich mit 14:
; 15 (some c: LegalComponent | some i: c.interfaces | (some o: (c.interfaces).iids | o not in (c.interfaces).iids)
; -- Widerspruch in sich. Also kann 4 nicht gelten, die Annahme von Fall 1.