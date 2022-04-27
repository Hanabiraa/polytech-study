#include "tasks.h"

void task2() {
    // num_threads() - кол-во процессов
    cout << "OMP FOR for 2 threads: \n";
#pragma omp parallel for num_threads(2)
    for (int i = 0; i < 4; ++i) {
        auto str = "i=" + to_string(i) + " Hello from thread: " + to_string(omp_get_thread_num()) + '\n';
        std::cout << str;
    }
    cout << "\n\n";

    /*
    "this and this can run in parallel".
    The sections setting is just for that.
    */
    cout << "OMP SECTION for 2 threads: \n";
#pragma omp parallel sections num_threads(2)
    {
#pragma omp section 
        {
            for (int i = 0; i < 2; ++i) {
                cout << "Hello from section 1 and thread: " + to_string(omp_get_thread_num()) + '\n';;
            }
        }
#pragma omp section 
        {
            for (int i = 0; i < 2; ++i) {
                cout << "Hello from section 2 and thread: " + to_string(omp_get_thread_num()) + '\n';;
            }
        }
    }
    cout << "\n\n";

    /*
    The barrier directive causes threads encountering the barrier
    to wait until all the other threads in the same team have
    encountered the barrier.
    */
    cout << "OMP BARRIER for 2 threads: \n";
#pragma omp parallel num_threads(2)
    {
        for (int i = 0; i < 2; ++i) {
            auto str = "before barrier. thread: " + to_string(omp_get_thread_num()) + '\n';
            std::cout << str;
        }
#pragma omp barrier
        for (int i = 0; i < 2; ++i) {
            auto str = "after barrier. thread: " + to_string(omp_get_thread_num()) + '\n';
            std::cout << str;
        }
    }
}
