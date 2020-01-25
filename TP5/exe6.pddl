(define (problem singe-bananes01)
(:domain monkey-dom)
(:objects positiona positionb positionc
       monkeym
       bananab
       boxb  
)
(:init (position positiona) (position positionb) (position positionc) 
       (monkey monkeym)
       (banana bananab)
       (box boxb)
       (at positiona monkeym) (at positionb boxb) (at positionc bananab)
       (down monkeym) (down boxb)
       (up bananab)
       (not (down bananab))
       (not (up monkeym))
       (not (carry monkeym bananab))
)

(:goal (and (at positionc monkeym)
       (up monkeym)
       (carry monkeym bananab)
))
)    