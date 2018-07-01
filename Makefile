# stock-prices Makefile

.PHONY: all clean

all: stock_gain stock_volatility stock_crossover

stock_gain: src/*.f90
	$(MAKE) --directory=src $@
	cp src/$@ .

stock_volatility: src/*.f90
	$(MAKE) --directory=src $@
	cp src/$@ .

stock_crossover: src/*.f90
	$(MAKE) --directory=src $@
	cp src/$@ .

figures: stock_volatility stock_crossover
	./stock_volatility
	./stock_crossover
	$(MAKE) --directory=plotting

clean:
	$(MAKE) --directory=src $@
	$(RM) *.txt stock_gain stock_volatility stock_crossover
