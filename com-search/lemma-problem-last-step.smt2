; problematic assertion
(assert 
 (! 
  (exists ((c Atom)) 
	(and 
		(in_1 c LegalComponent) 
		(exists ((i Atom))
		(and 
			(in_1 i Interface)
			(in_1 i (join_1x2 (a2r_1 c) interfaces))
			(not 
				(subset_1 
					(join_1x2 (a2r_1 c) iids1) 
					(join_1x2 (a2r_1 i) iidsKnown)))
  ))))
 :named knownAssertion
 ) 
 )
;; --end assertions

;; command (contradiction to assertion)
(assert 
 (! 
  (not 
	(forall ((c Atom)) 
	(=> 
		(in_1 c LegalComponent) 
		(forall ((i Atom)) 
		(=> 
			(and 
				(in_1 i Interface) 
				(in_1 i (join_1x2 (a2r_1 c) interfaces))) 
			(subset_1 
				(join_1x2 (a2r_1 c) iids1) 
				(join_1x2 (a2r_1 i) iidsKnown))))))) 
 :named VerificationCondition
 ) 
 )
;; --end command

 ;; --end axioms
(check-sat)
