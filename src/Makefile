# stock-prices Makefile

OBJS = mod_alloc.o mod_arrays.o mod_io.o

all: stock_gain

.SUFFIXES: .f90 .o

# general rule
.f90.o:
	$(FC) -c $<

# programs
stock_gain: stock_gain.f90 $(OBJS)
	$(FC) $< $(OBJS) -o $@

stock_volatility: stock_volatility.f90 $(OBJS)
	$(FC) $< $(OBJS) -o $@

stock_crossover: stock_crossover.f90 $(OBJS)
	$(FC) $< $(OBJS) -o $@

# modules
mod_alloc.o: mod_alloc.f90
mod_arrays.o: mod_arrays.f90
mod_io.o: mod_io.f90 mod_alloc.o

.PHONY:
clean:
	$(RM) *.o *.mod stock_gain stock_volatility stock_crossover
