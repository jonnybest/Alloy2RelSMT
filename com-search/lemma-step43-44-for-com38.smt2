;; all c: LegalComponent | all i: c.interfaces | i.iids in i.iidsKnown // 43' 
;; => 
;; all i: LegalInterface | i.iids in i.iidsKnown // 44' = not 44 (valid) 

(assert ; 43
 (! (forall ((c Atom)) (=> 
	(in_1 c T) 
	(forall ((i Atom)) (=> 
		(and 
			(in_1 i B) 
			(in_1 i (join_1x2 (a2r_1 c) A))) 
			(subset_1 
				R 
				S))))) 
 :named a30 
 ) 
 )
;; implies
(assert ; 44'
 (! 
  (forall ((i Atom)) (=> 
	(in_1 i LegalInterface) 
	(subset_1 
		R
		S))) 
 :named a31 	
 ) 
 )
 
;; as lemma: 
(assert ; 43->44
(forall ((a Rel1)(b Rel1)(r1 Rel2)(r2 Rel2))
(=>
	(subset_1 b a)
	(=>  
		(subset_1 
			(join_1x2 a r1) 
			(join_1x2 a r2))
		(subset_1 
			(join_1x2 b r1) 
			(join_1x2 b r2)))) 
 ))
 ;; as a negative lemma: 
(assert ; 43->44
(exists ((i Atom)(a Rel1)(b Rel1)(r1 Rel2)(r2 Rel2))
(and
	(not (in_1 i b))
	(subset_1 b a)
	(=>  
		(not (subset_1 
			(join_1x2 a r1) 
			(join_1x2 a r2)))
		(not (subset_1 
			(join_1x2 b r1) 
			(join_1x2 b r2)))))))
 
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
