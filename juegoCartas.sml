(*Codigo de referencia*)
datatype suit = Clubs|Diamonds|Hearts|Spades
datatype rank = Jack|Queen|King|Ace|Num of int
type card = suit*rank
datatype color= Red|Black
datatype move= Discard of card|Draw

exception IllegalMove
(*Funcion que indica el color de cada carta*)
fun card_color(c:card)=
    case #1 c of
    	(Clubs|Spades) =>Black
    	|(Hearts|Diamonds)=> Red 



(*Funcion que indica el el valor de cada carta según el rankc*)
fun card_value(c:card)=
    case c of
        (_,Jack)=>10
        |(_,Queen)=>10
        |(_,King)=>10
        |(_,Ace)=>11
       
        |(_,Num i)=>i

(*Funcion que devuelve una lista sin la carta que se elimino*)
fun remove_card(cs:card list, c: card, e: exn)=
    case cs of
        [] => raise e
        | head :: rest => if c = head
                          then rest
                          else remove_card(rest,c,e)
                          
   
(*Funcion que suma los valores del rank del maso de cartas*)
fun sum_cards(cs: card list)=
    let fun aux_sum(cs,acum)=
        case cs of
            [] => acum
            | head :: rest => aux_sum(rest , acum + card_value(head)) 
    in
        aux_sum(cs,0)
    end
    
(*Funcion que dice si todas las cartas del maso son iguales*)
(*usa funcion card color para saber que color tiene*)
fun all_same_color(cs : card list) =
    case cs of 
        [] => true
      | _::[] => true
      | head::(neck::rest) => (card_color(head)=card_color(neck) andalso 
                               all_same_color(neck::rest))

(*Funcion que calcula el puntaje del jugador segun la suma del rank de su maso de cartas*)

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


(*Funcion que indicaque termina el juego, indica el puntaje final de un jugador según los movimientos implementados *)
fun officiate (card_list: card list, move_list: move list, goal: int) =
    let 
        fun helper (card_list_aux: card list,cards_held_aux: card list,move_list_aux: move list) =
        
            case move_list_aux of
                [] => score(cards_held_aux, goal)(*si ya no hay mas movimiento termina*)
                
              | (Discard crd)::rest_ml => helper(card_list_aux,remove_card(cards_held_aux, crd, IllegalMove),rest_ml)(*remover larta de held-card en llamada recursiva*)
                                          
              | _::rest_ml => (case card_list_aux of (*si no es discard ejecuta este caso*)
                                [] => score(cards_held_aux, goal) (*si card-list []termina juego*)
                              | head_cl::rest_cl => if sum_cards(head_cl::cards_held_aux)>goal
                                         then 
                                            score(head_cl::cards_held_aux, goal)
                                         else 
                                            helper(rest_cl, head_cl::cards_held_aux, rest_ml)) (*llamada recursiva con card-list mas pequeno y held-card mas grande*)
              
    in
        helper(card_list, [], move_list)
    end
  



  

	    
