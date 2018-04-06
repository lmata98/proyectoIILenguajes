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

fun remove_card(cs:card list, c: card, e: exn)=
    case cs of
        [] => raise e
        | head :: rest => if c = head
                          then rest
                          else remove_card(rest,c,e)
                          
val test3 = remove_card([(Hearts,Ace),(Clubs,Ace)],(Hearts,Ace), IllegalMove)       



fun sum_cards(cs: card list)=
    let fun aux_sum(cs,acum)=
        case cs of
            [] => acum
            | head :: rest => aux_sum(rest , acum + card_value(head)) 
    in
        aux_sum(cs,0)
    end
    
val test5 = sum_cards[(Clubs,Num 5),(Clubs, Ace)]


fun all_same_color (cs : card list) =
    case cs of 
        [] => true
      | _::[] => true
      | head::(neck::rest) => (card_color(head)=card_color(neck) andalso 
                               all_same_color(neck::rest))

fun score(hd: card list, goal: int )=
    let 
        val sum = sum_cards(hd)
        val score_1 = 3*(sum-goal)
        val score_2 = goal-sum
        val calc_score =  if sum > goal
                         then score_1
                         else score_2
    in
        if all_same_color(hd)
        then calc_score div 2
        else calc_score
       
    end
    
val test6 = score([(Hearts,Num 3),(Clubs, Num 4)],10)

fun officiate(card_list: card list, move_list: move list, goal: int)=
    let 
	fun helper(card_list_aux:card list,move_list_aux:move list,held_list_aux:card list)=
	    case move_list_aux of
		[] => score(held_list_aux,goal)
	      (*tomar la cabeza de la lista, si es Discard hace match con el segundo case,en llamada recursiva se llama a la funcion remove para eliminar carta solicitada*)
	      | ( Discard crd)::rest => helper(card_list_aux,rest,remove_card(held_list_aux,crd,IllegalMove)) 
	      |  _::rest => (case card_list_aux of (*si la cabeza no es Discart hace match lo otro que se, en este caso sea con Draw, entra ejecuta este case*) 
				 []=> score(held_list_aux,goal)(*termina el juego y da como resultado el score*)
			      | head::rest => if(sum_cards(head::held_list_aux) > goal)(*validar si la suma de held-card con una carta m�s no sea mayoa que goaldel >< que goal*)
					      then 
						  score(held_list_aux,goal)(*si la suma es mayor, el juego termina y da el score*)
					      else
						  helper(rest,move_list_aux,head::held_list_aux)(*continua el juego con held car mas grande y card list mas peque�o*))(*fin del case Draw*)
    in
	helper(card_list,move_list,[])
    end
  
val test7 = officiate([(Hearts,Num 2),(Clubs, Num 4)],[Draw],15)