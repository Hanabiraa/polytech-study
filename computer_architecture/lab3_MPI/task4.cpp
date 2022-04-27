#include "tasks.h"

void task4() {
	omp_lock_t my_lock;
	omp_init_lock(&my_lock);
#pragma omp parallel num_threads(4)
    {
        for (int i = 0; i < 2; ++i) {
            omp_set_lock(&my_lock);
            printf_s("Thread %d - starting locked region\n", omp_get_thread_num());
            printf_s("Thread %d - ending locked region\n", omp_get_thread_num());
            omp_unset_lock(&my_lock);
        }
    }

    omp_destroy_lock(&my_lock);
}