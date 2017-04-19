%elementfacts
noun(i).
noun(you).
noun(he).
noun(she).
noun(it).
noun(we).
noun(they).
noun(ali).
noun(esra).
noun([]).
verb(eat).
verb(gone).
verb([]).
object(apple).
object(home).
object([]).

%translationfacts
translation(ali,ali).
translation(esra,esra).
translation(eat,yer).
translation(eats,yer).
translation(ate,yedi).
translation(eaten,yedi).
translation(gone,gitti).
translation(apple,elma).
translation(home,ev).
translation(boy,cocuk).
translation(has,sahip).




the_translator(Y) :- (maplist(translation, Y, Z)),
                      the_scribe(Z).
			
			
re_org([N1,V1,Obj]) :- append([N1],[Obj],Org),
                       append(Org,[V1],Orga),
                       the_translator(Orga).
               

the_parsemaster(U) :- nounparser(U).

nounparser([N1|T]):-noun(N1),!,write(N1),tab(1),write(T),tab(1),nl,append([N1],[],TR),verbparser(T,TR).
nounparser([_|T]):-write('DEBUG: noun'),nounparser(T).

verbparser([V1|T],TR):-verb(V1),!,write(V1),tab(1),write(T),tab(1),write(TR),append(TR,[V1],TR1),write(TR1),nl,objectparser(T,TR1).
verbparser([_|T],TR):-write('DEBUG: verb'),verbparser(T,TR).

objectparser([Obj|T],TR):-object(Obj),!,write(Obj),tab(1),write(T),tab(1),write(TR),nl,append(TR,[Obj],Ret),write(Ret),nl,the_translator(Ret).
objectparser([_|T],TR):-write('DEBUG: object'),objectparser(T,TR).



the_inputmaster :- 	read_line_to_codes(user_input,Cs), 
	                atom_codes(A, Cs), 
	                atomic_list_concat(L, ' ', A),
					the_parsemaster(L).
					%the_translator(L,_).
	 
				
the_scribe(Tr) :-  maplist(term_to_atom, Tr, L1),
                   atomic_list_concat(L1, ' ', L2),
                   write('Turkish translation: '), write(L2).                    	
                    
topkek :- write('Please enter the sentence to be translated: '),
          the_inputmaster.
		  
          
	 
	 
	 
	 
		
	
		
		
		


					 