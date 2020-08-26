# Michael Guerrero & Michael Figura

GHDL = /usr/local/bin/ghdl

default: calculator_test

calculator:
	$(GHDL) -a --ieee=standard isa_reg.vhdl
	$(GHDL) -a --ieee=standard skip.vhdl
	$(GHDL) -a --ieee=standard addsub_8.vhdl
	$(GHDL) -a --ieee=standard isa_calc.vhdl
	$(GHDL) -a --ieee=standard isa_calc_tb.vhdl
	$(GHDL) -e --ieee=standard isa_calc_tb



calculator_test: calculator
	$(GHDL) -r isa_calc_tb
