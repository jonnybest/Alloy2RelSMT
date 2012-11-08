;; 43 (not valid)
;; => 
;; 44 (not valid)

(assert ; 43
 (! 
  (exists ((c Atom)) 					; step 43
		(and 
			(in_1 c LegalComponent) 
			(exists ((i Atom)) 
			(and 
				(in_1 i Interface)			; optional
				(in_1 i (join_1x2 (a2r_1 c) interfaces))
				(not (subset_1 
					(join_1x2 (a2r_1 i) iids1) 
					(join_1x2 (a2r_1 i) iidsKnown)))))))

 :named a31 
 ) 
 )
;; gdw.
(assert ; 44
 (! 
  (exists ((i Atom)) 					; step 44
		(and 
			(in_1 i LegalInterface) 
			(not (subset_1 
				(join_1x2 (a2r_1 i) iids1)
				(join_1x2 (a2r_1 i) iidsKnown)))))

 :named a31 
 ) 
 )
 
;; as lemma: 
(=> 
	(and
		(subset_1 LegalInterface Interface) 
		(subset_2 interfaces (prod_1x1 Component Interface))
		(subset_1 (join_1x2 LegalComponent interfaces) LegalInterface) 
	)
	(= 
		(exists ((c Atom))
		(and 
			(in_1 c LegalComponent) 
			(exists ((i Atom)) 
			(and 
				(in_1 i Interface)
				(in_1 i (join_1x2 (a2r_1 c) interfaces))
				(not (subset_1 
					(join_1x2 (a2r_1 i) iids1) 
					(join_1x2 (a2r_1 i) iidsKnown)))))))
		(exists ((i Atom)) 
		(and 
			(in_1 i LegalInterface) 
			(not (subset_1 
				(join_1x2 (a2r_1 i) iids1)
				(join_1x2 (a2r_1 i) iidsKnown)))))

	)
)
 
;; general lemma:
;; 
-- proof outline: ((((A2 und 14) <=> 42) und 45 ) => 43) <=> 44 ? 38
-- im Modell steht:
14 all c : Component | c.iids = c.interfaces.iids -- line 65
-- ganz allgemein gilt auch folgendes Lemma (obda):
45 all c: Component| all i:c.interfaces | i.iids in c.interfaces.iids
-- aus A2 mit 14 (gdw):
42 some c: LegalComponent | some i: c.interfaces | c.interfaces.iids not in i.iidsKnown
-- aus 42 ergibt sich, wegen 45 insbesondere ((((A2 und 14) <=> 42) und 45 ) => 43):
43 some c: LegalComponent | some i: c.interfaces | i.iids not in i.iidsKnown
-- aus 43 ergibt sich, wegen (c.interfaces in LegalInterface) ganz allgemein (gdw): ((((A2 und 14) <=> 42) und 45 ) => 43) <=> 44 ? 38
44 some i: LegalInterface | i.iids not in i.iidsKnown
-- reflexivity l.76
38 all i: LegalInterface | i.iids in i.iidsKnown
-- 38 steht nun im Widerspruch zu 44. wzbw ?
