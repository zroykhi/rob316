(define (domain exe5-dom)
   (:predicates 
   		(node ?n)
		(agent ?a)
		(at ?n ?a)
		; there is a direction
		(arc ?n ?m)
	)

	(:action aller
		:parameters (?from ?to ?agent)
		:precondition (and (node ?from) (node ?to) (agent ?agent) (at ?from ?agent)
(arc ?from ?to))
		:effect (and (at ?to ?agent) (not (at ?from ?agent)))
	)
)
