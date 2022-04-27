#include "tasks.h"

void task3() {

	/*
	The single construct specifies that the given statement/block
	is executed by only one thread. It is unspecified which thread.
	Other threads skip the statement/block and wait at an implicit barrier
	at the end of the construct.
	*/
	cout << "OMP SINGLE: \n";
	#pragma omp parallel
	{
		cout << "executed for thread: " + to_string(omp_get_thread_num()) + '\n';
		#pragma omp single
		{
			cout << "executed only ONCE by thread: " + to_string(omp_get_thread_num()) + '\n';
		}
	}
	cout << "\n\n";

	/*
	The critical construct restricts the execution of the associated
	statement / block to a single thread at time.
	*/
	cout << "OMP CRITICAL: \n";
	#pragma omp parallel
	{
		#pragma omp critical 
		cout << "Try" << " " << "to" << " " << "print" << "\n";
	}
}