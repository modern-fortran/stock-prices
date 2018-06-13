# stock-prices Makefile

.PHONY: all clean

all: stock_gain

stock_gain: src/*.f90
	$(MAKE) --directory=src $@
	cp src/$@ .

clean:
	rm stock_gain
	$(MAKE) --directory=src $@
