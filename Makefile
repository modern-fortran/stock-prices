# stock-prices Makefile

.PHONY: all clean

all: stock_prices

stock_prices:
	$(MAKE) --directory=src $@
	cp src/$@ .

clean:
	$(MAKE) --directory=src $@
	rm stock_prices
