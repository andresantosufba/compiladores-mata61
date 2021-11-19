_e1_:_e1_.y _e1_.l expr.h
	bison -Wconflicts-sr -d -v _e1_.y
	flex  _e1_.l
	gcc -o $@ _e1_.tab.c expr.c lex.yy.c 





