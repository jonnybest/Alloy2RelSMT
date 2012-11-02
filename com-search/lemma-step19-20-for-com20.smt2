; some c: LegalComponent | some i: c.interfaces | some o : c.iids | o not in i.qi.Interface // 19
; some c: LegalComponent | some i: c.interfaces | some o : c.iids | no o.(i.qi) // 20

; model
(assert 
 (! 
  (exists ((c Atom)) (and (in_1 c LegalComponent) (exists ((i Atom)) (and 
    (in_1 i Interface)
    (in_1 i (join_1x2 (a2r_1 c) interfaces))
    (exists ((o Atom)) (and 
    (in_1 o IID)
    (in_1 o (join_1x2 (a2r_1 c) iids))
    (not (in_1 o (join_2x1 (join_1x3 (a2r_1 i) qi) Interface)))
  ))
  )))) 
 :named a28 
 ) 
 )
;; --end model

;; command
(assert 
 (! 
  (not (exists ((c Atom)) (and (in_1 c LegalComponent) (exists ((i Atom)) (and 
    (in_1 i Interface)
    (in_1 i (join_1x2 (a2r_1 c) interfaces))
    (exists ((o Atom)) (and 
    (in_1 o IID)
    (in_1 o (join_1x2 (a2r_1 c) iids))
    (no_1 (join_1x2 (a2r_1 o) (join_1x3 (a2r_1 i) qi)))
  ))
  ))))) 
 :named c0 
 ) 
 )
;; --end command

; step 19->20

(assert 
(=> 
	(subset_2 
		(join_1x3 (a2r_1 i) qi)
		(prod_1x1 IID Interface))
	(=> 
		(not (in_1 o (join_2x1 (join_1x3 (a2r_1 i) qi) Interface)))
		(no_1 (join_1x2 (a2r_1 o) (join_1x3 (a2r_1 i) qi)))
	))

; general lemma 
(assert
 (! 
  ; lemma for step 19->20
  ; some c: LegalComponent | some i: c.interfaces | some o : c.iids | o not in i.qi.Interface // 19
  ; to (with Lemma (all A,B,R | ( R in A->B => (all a in A | no a in a.r => a not in B )))
  ; some c: LegalComponent | some i: c.interfaces | some o : c.iids | no o.(i.qi) // 20
(forall ((R Rel2)(A Rel1)(B Rel1)) 
(=>
	(subset_2 R (prod_1x1 A B))
	(forall ((x Atom))
	(=> 
		(in_1 x A)
		(=
			(not (in_1 x (join_2x1 R B)))
			(no_1 (join_1x2 (a2r_1 x) R)))))))
 :named lstep20
 ) 
 )
;; --end lemmas

; lemma is valid. but not useful.