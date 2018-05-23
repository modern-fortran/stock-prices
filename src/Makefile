# stock-prices Makefile

FC = gfortran
OBJS = mod_arrays.o mod_io.o

all: stock_prices

.SUFFIXES: .f90 .o

# general rule
.f90.o:
	$(FC) -c $<

# programs
stock_prices: stock_prices.f90 $(OBJS)
	$(FC) $< $(OBJS) -o $@

# modules
mod_arrays.o: mod_arrays.f90
mod_io.o: mod_io.f90

.PHONY:
clean:
	rm *.o *.mod stock_prices
