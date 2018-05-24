# stock-prices Makefile

.PHONY: all clean

all: stock_prices

stock_prices: src/*.f90
	$(MAKE) --directory=src $@
	cp src/$@ .

clean:
	rm stock_prices
	$(MAKE) --directory=src $@
