# stock-prices Makefile

FC = gfortran
OBJS = mod_alloc.o mod_arrays.o mod_io.o

all: stock_prices

.SUFFIXES: .f90 .o

# general rule
.f90.o:
	$(FC) -c $<

# programs
stock_prices: stock_prices.f90 $(OBJS)
	$(FC) $< $(OBJS) -o $@

# modules
mod_alloc.o: mod_alloc.f90
mod_arrays.o: mod_arrays.f90
mod_io.o: mod_io.f90 mod_alloc.o

.PHONY:
clean:
	rm *.o *.mod stock_prices
