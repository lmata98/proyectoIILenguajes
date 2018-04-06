(*Codigo de referencia*)
datatype suit = Clubs|Diamonds|Hearts|Spades
datatype rank = Jack|Queen|King|Ace|Num of int
type card = suit*rank
datatype color= Red|Black
datatype move= Discard of card|Draw

exception IllegalMove

fun card_color(c:card)=
    case #1 c of
    	(Clubs|Spades) =>Black
    	|(Hearts|Diamonds)=> Red 

val test1 = card_color(Clubs,Num 2)


fun card_value(c:card)=
    case c of
        (_,Jack)=>10
        |(_,Queen)=>10
        |(_,King)=>10
        |(_,Ace)=>11
        |(_,Num 2) => 2
        |(_,Num 3) => 3
        |(_,Num 4) => 4
        |(_,Num 5) => 5
        |(_,Num 6) => 6
        |(_,Num 7) => 7
        |(_,Num 8) => 8
        |(_,Num 9) => 9
        (*|(_,Num i)=>i*)

       

val test2 = card_value(Spades,Queen)

