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
