FC=gfortran
#FFLAGS=-Wall -std=legacy -fimplicit-none -Wno-maybe-uninitialized -Wno-unused-function -flto
#FOPT=-O3 -ftree-vectorize -fopt-info-vec

FOPT=-w
FFLAGS=-std=f2008

allRun:
	# clean project
	rm -rf obj/*
	rm -rf bin/*

	# compute math library
	$(FC) $(FFLAGS) $(FOPT) -c src/compute_math_library/src/DECOMP.F -J obj/ -o obj/DECOMP.o
	$(FC) $(FFLAGS) $(FOPT) -c src/compute_math_library/src/FEHL.F -J obj/ -o obj/FEHL.o
	$(FC) $(FFLAGS) $(FOPT) -c src/compute_math_library/src/FMIN.F -J obj/ -o obj/FMIN.o
	$(FC) $(FFLAGS) $(FOPT) -c src/compute_math_library/src/QUANC8.F -J obj/ -o obj/QUANC8.o
	$(FC) $(FFLAGS) $(FOPT) -c src/compute_math_library/src/RKF45.F -J obj/ -o obj/RKF45.o
	$(FC) $(FFLAGS) $(FOPT) -c src/compute_math_library/src/RKFS.F -J obj/ -o obj/RKFS.o
	$(FC) $(FFLAGS) $(FOPT) -c src/compute_math_library/src/SEVAL.F -J obj/ -o obj/SEVAL.o
	$(FC) $(FFLAGS) $(FOPT) -c src/compute_math_library/src/SOLVE.F -J obj/ -o obj/SOLVE.o
	$(FC) $(FFLAGS) $(FOPT) -c src/compute_math_library/src/SPLINE.F -J obj/ -o obj/SPLINE.o
	$(FC) $(FFLAGS) $(FOPT) -c src/compute_math_library/src/SVD.F -J obj/ -o obj/SVD.o
	$(FC) $(FFLAGS) $(FOPT) -c src/compute_math_library/src/URAND.F -J obj/ -o obj/URAND.o
	$(FC) $(FFLAGS) $(FOPT) -c src/compute_math_library/src/ZEROIN.F -J obj/ -o obj/ZEROIN.o

	# project files
	$(FC) $(FFLAGS) -c src/environment.f90 -J obj/ -o obj/environment.o
	$(FC) $(FFLAGS) -c src/group_process.f90 -J obj/ -o obj/group_process.o
	$(FC) $(FFLAGS) -c src/main.f90 -I obj/ -o obj/main.o


	# compile all
	$(FC) $(FFLAGS) -o bin/app ./obj/DECOMP.o ./obj/FEHL.o ./obj/FMIN.o ./obj/QUANC8.o ./obj/RKF45.o ./obj/RKFS.o ./obj/SEVAL.o ./obj/SOLVE.o ./obj/SPLINE.o ./obj/SVD.o ./obj/URAND.o ./obj/ZEROIN.o ./obj/environment.o ./obj/group_process.o obj/main.o

	cd ./bin; ./app;
	# ls -ll bin/output*
