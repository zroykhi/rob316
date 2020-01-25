(define (problem exe3) 
(:domain BLOCKS)
(:objects D B A C)
(:init
    (CLEAR B) (ON B C) (ON C A) (ON A D) (ONTABLE D) (HANDEMPTY)
)
(:goal (and
    (ON D C) (ON C A) (ON A B)
))
)
