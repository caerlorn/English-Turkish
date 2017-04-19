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
noun(cat).
noun(child).
noun([]).
verb(eat).
verb(ate).
verb(went).
verb(gone).
verb(eaten).
verb([]).
object(apple).
object(home).
object(mouse).
object([]).

%translationfacts
translation(i,ben).
translation(you,sen).
translation(he,o).
translation(she,o).
translation(it,o).
translation(we,biz).
translation(they,onlar).
translation(ali,ali).
translation(esra,esra).
translation(cat,kedi).
translation(child,cocuk).
translation(ate,yedi).
translation(eaten,yedi).
translation(went,gitti).
translation(gone,gitti).
translation(apple,elma).
translation(mouse,fare).
translation(home,eve).
translation(eat,yer).



%articles, 3 determiners and 1 present perfect tense article(for experimental purposes)
article(a).
article(an).
article(the).
article(has).


%Simple past tense
tense(ben,m).
tense(sen,n).
tense(o,' ').
tense(biz,k).
tense(onlar,ler).
tense(_,' ').


%Rules
%R is the Returned sentence(translated) : R0 contains noun, R1 is R0 appended with object, R2 is R1 appended with verb, R2 contains the final translation
%L is the empty list filled with atoms
%I is the input string
%H - head of current list, T - tail of current list
%TRN noun translation, TRV verb translation, TRO object translation


inputunefendisi :- 	read_line_to_codes(user_input,Cs), 
					atom_codes(A, Cs), 
					atomic_list_concat(L, ' ', A),
					sentence1(L).
					
					
sentence(I):-  atomic_list_concat(L,' ',I),!,nounparser(L).
sentence1(L):- nounparser(L).

nounparser([H|T]):- noun(H),!,write(H),tab(1),write(T),tab(1),translation(H,TRN),append([TRN],[],R0),write(R0),nl,verbparser(T,R0).
nounparser([_|T]):- write('DEBUG: noun '),nounparser(T).

verbparser([H|T],R0):- verb(H),!,write(H),tab(1),write(T),tab(1),nl,objectparser(T,R0,H).
verbparser([_|T],R0):- write('DEBUG: verb '),verbparser(T,R0).

objectparser([],R1,VERB):- write('eof'),nl,verbappend(VERB,R1).
objectparser([H|T],R1,VERB):- object(H),!,write(H),tab(1),write(T),tab(1),write(R1),nl,write('eof'),
                              translation(H,TRO),append(R1,[TRO],R2),write(R2),nl,verbappend(VERB,R2).
objectparser([_|T],R1,VERB):- write('DEBUG: object '),objectparser(T,R1,VERB).

verbappend(VERB, R2):- translation(VERB,TRV),append(R2,[TRV],TENSELESS),tensedetector(TENSELESS,Value),
                       append(TENSELESS,[Value],RESULT),write(RESULT),nl,printer(RESULT).

tensedetector([H|_],Value):- tense(H,Value).


printer([H|T]):- write('Turkish translation: '),write(H),write(' '),printloop(T).
printloop([]):- !.
printloop([H|T]):- translation(TEMP,H),verb(TEMP),write(' '),write(H),printloop(T).
printloop([H|T]):- translation(TEMP,H),verb(TEMP),write(' '),write(H),printloop(T).
printloop([H|T]):- tense(H,_),write(H),printloop(T).





%starters
go0:- sentence('ali ate apple').
go1:- sentence('esra went home').
go2:- sentence('the cat has eaten a mouse').
go3:- sentence('i went home').
go4:- sentence('you went home').
go5:- sentence('he went home').
go6:- sentence('she went home').
go7:- sentence('it went home').
go8:- sentence('we went home').
go9:- sentence('they went home').
go10:- go0,go1,go2,go3,go4,go5,go6,go7,go8,go9.
topkek :- write('Please enter the sentence to be translated: '),
          inputunefendisi.

