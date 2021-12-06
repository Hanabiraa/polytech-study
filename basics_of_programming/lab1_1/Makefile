FC=gfortran
FFLAGS=-Wall -std=f2018 -fimplicit-none -Wno-maybe-uninitialized -Wno-unused-function -flto
FOPT=-O3 -ftree-vectorize -fopt-info-vec

all:
	$(FC) $(FFLAGS) -c src/environment.f90 -J obj/ -o obj/environment.o
	$(FC) $(FFLAGS) $(FOPT) -c src/main.f90 -I obj/ -o obj/main.o
	$(FC) $(FFLAGS) $(FOPT) -o bin/app ./obj/environment.o obj/main.o

clean:
	rm -rf obj/*
	rm -rf bin/*

run:
	cd ./bin; ./app;
	cat bin/output.txt

create_dir:
	mkdir src
	mkdir bin
	mkdir data
	mkdir obj
	touch ./data/input.txt
