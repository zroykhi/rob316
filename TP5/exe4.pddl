(define (problem exe4) 
(:domain BLOCKS)
(:objects A B C D E F G H I J)
(:init
    (CLEAR C) (ON C G) (ON G E) (ON E I) (ON I J) (ON J A) (ON A B) (ONTABLE B) 
    (CLEAR F) (ON F D) (ON D H) (ONTABLE H)
    (HANDEMPTY)
)
(:goal (and
    (ON C B) (ON B D) (ON D F) (ON F I) (ON I A) (ON A E) (ON E H) (ON H G) (ON G J)
))
)