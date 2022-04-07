FC=gfortran
#FFLAGS=-Wall -std=legacy -fimplicit-none -Wno-maybe-uninitialized -Wno-unused-function -flto
#FOPT=-O3 -ftree-vectorize -fopt-info-vec

FOPT=-w -fcheck=all
FFLAGS=-std=f2008

allRun:
	# clean project
	rm -rf obj/*
	rm -rf bin/*

	# compute math library
	$(FC) $(FFLAGS) $(FOPT) -c src/compute_math_library/src/RKFS.F -J obj/ -o obj/RKFS.o
	$(FC) $(FFLAGS) $(FOPT) -c src/compute_math_library/src/FEHL.F -J obj/ -o obj/FEHL.o
	$(FC) $(FFLAGS) $(FOPT) -c src/compute_math_library/src/RKF45.F -J obj/ -o obj/RKF45.o

	# project files
	$(FC) $(FFLAGS) $(FOPT) -c src/environment.f90 -J obj/ -o obj/environment.o
	$(FC) $(FFLAGS) $(FOPT) -c src/group_process.f90 -J obj/ -o obj/group_process.o
	$(FC) $(FFLAGS) $(FOPT) -c src/main.f90 -I obj/ -o obj/main.o

	# compile all
	$(FC) $(FFLAGS) $(FOPT) -o bin/app ./obj/RKF45.o ./obj/RKFS.o ./obj/FEHL.o ./obj/environment.o ./obj/group_process.o obj/main.o

	cd ./bin; ./app;
	# ls -ll bin/output*
