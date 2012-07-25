(set-logic AUFLIA)
(set-option :macro-finder true)
(set-option :produce-unsat-cores true)
;; functions
(declare-fun f () Bool)
(declare-fun g () Bool)

;; axioms
(assert 
(and
 (! 
	(or (not f) g)
	:named a)
	(!
	(or f (not g))
	:named b)
	(!
	(=> f g)
	:named c)
	(!
	(=> g f)
 :named d)
 )
 )

(check-sat)
(get-model) 