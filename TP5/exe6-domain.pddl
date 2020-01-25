;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Singe Bananes World
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (domain monkey-dom)
   (:predicates (position ?p)
		(monkey ?m)
		(banana ?b)
		(box ?bo)
		(at ?p ?m)
		(up ?m)
		(down ?m)
		(carry ?m ?b)
	)

	(:action aller
		:parameters (?from ?to ?monkey)
		:precondition (and (position ?from) (position ?to) (at ?from ?monkey) (monkey ?monkey) (down ?monkey))
		:effect (and (at ?to ?monkey) (not (at ?from ?monkey)))
	)

	(:action pousser
		:parameters (?from ?to ?box ?monkey)
		:precondition (and (position ?from) (position ?to) (box ?box) (monkey ?monkey) (at ?from ?monkey) 
			(at ?from ?box) (down ?monkey) (down ?box))
		:effect (and (at ?to ?monkey) (not (at ?from ?monkey)) (at ?to ?box) (not (at ?from ?box)))
	)

	(:action monter
		:parameters (?place ?box ?monkey)
		:precondition (and (position ?place) (box ?box) (monkey ?monkey) (at ?place ?monkey) (at ?place ?box) 
			(down ?monkey) (down ?box))
		:effect (and (up ?monkey) (not (down ?monkey)))
	)

	(:action attraper
		:parameters (?place ?monkey ?banana)
		:precondition (and (position ?place) (banana ?banana) (monkey ?monkey) (at ?place ?monkey) 
			(at ?place ?banana) (up ?monkey) (up ?banana))
		:effect (and (carry ?monkey ?banana))
	)

	(:action descendre
		:parameters(?place ?box ?monkey)
		:precondition (and (position ?place) (box ?box) (monkey ?monkey) (at ?place ?monkey) (at ?place ?box) 
			(up ?monkey))
		:effect (and (down ?monkey) (not (up ?monkey)))
	)

	(:action lacher
		:parameters (?banana ?place ?monkey)
		:precondition (and (position ?place) (banana ?banana) (monkey ?monkey) (carry ?monkey ?banana) (at ?place ?monkey) 
		(up ?monkey) (up ?banana) (at ?place ?banana)
		)
		:effect (and 
			(down ?banana)
			(not (carry ?monkey ?banana))
		)
	)	


)