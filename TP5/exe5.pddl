(define (problem exe5)
(:domain exe5-dom)
(:objects nodea nodeb nodec noded nodee
       agenta 
)
(:init (node nodea) (node nodeb) (node nodec) (node noded) 
       (node nodee)
       (agent agenta)

       (at nodea agenta)

       (arc nodea nodeb)
       (not (arc nodeb nodea))

       (arc nodeb nodec)
       (not (arc nodec nodeb))

       (arc nodec noded)
       (not (arc noded nodec))

       (arc nodea nodee)
       (not (arc nodee nodea))
)

(:goal (and 
       (at noded agenta)
))
)    
