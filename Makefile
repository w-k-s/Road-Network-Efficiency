build: clean
	mkdir -p build/units
	fpc -vnwh  					\ #show warnings, notes and hints\
	    -gl 					\
	    -gv 					\
	    -gw2					\
		-Fusrc 					\
	    -FEbuild 				\
		-FUbuild/units 			\
		cli.pas

clean:
	rm -rf build/**

