cc = g++
ccopts = #-ly
lex = flex
lexopts =
lexgens = lex.yy.c
yacc = bison
yaccopts = -dy
yaccgens = y.tab.c y.tab.h
prj = c-

$(prj): $(lexgens) $(yaccgens)
	$(cc) $(lexgens) $(yaccgens) $(ccopts) -o $(prj)

clean:
	rm $(lexgens) $(yaccgens) $(prj)

$(yaccgens): parser.y
	$(yacc) $(yaccopts) parser.y

$(lexgens): parser.l $(yaccgens)
	$(lex) $(lexopts) parser.l
