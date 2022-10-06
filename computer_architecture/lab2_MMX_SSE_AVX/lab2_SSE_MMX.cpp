#include <stdio.h>
#include <conio.h>
#include <mmintrin.h >
#include <xmmintrin.h>
#include <immintrin.h>
#include <iostream>
#include <locale.h>
#include <cstdlib>
#include <dvec.h>
#include <ivec.h>

int main(void) {

	setlocale(LC_ALL, "Russian");

	//MMX
	char qw1[8] = { 1, 2, 3, 4, 5, 6, 7, 83921983981212 };
	char qw2[8] = { 8, 7, 6, 5, 4, 3, 2, 1 };
	_asm {
		movq	mm0, qw1
		movq	mm1, qw2
		paddb	mm0, mm1
		movq	qw1, mm0
	}
	printf("%s\n", "MMX. Арифметика с насыщением (не циклическая) :");
	for (int i = 0; i < 8; i++)
	{
		printf("%d ", qw1[i]);
	}
	printf("\n\n\n");



	int sdvig[4] = { 1, 32, 64, 128 };
	int sdvig_b[4] = { -1, 128, 64, 32 };
	_asm {
		//sse
		//Перестановка байт, каждый байт результата есть некоторый байт из первого аргумента,
		//определяемый по соответствующему байту из второго аргумента(если байт отрицательный,
		//то в байт результат прописывается ноль, иначе используются младшие 3 или 4 бита как номер байта
		//в первом аргументе).
		movups	xmm0, sdvig
		movups	xmm1, sdvig_b
		pshufb  xmm0, xmm1
		movups	sdvig, xmm0
	}
	printf("%s\n", "SSE3 shuffle:");
	for (int i = 0; i < 4; i++)
	{
		printf("%d ", sdvig[i]);
	}
	printf("\n\n\n");

	// загрузка со старшего до младшего
	_mm_empty();
	__m256 a = _mm256_set_ps(8.54, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0);
	__m256 b = _mm256_set_ps(18.0, 17.0, 16.0, 15.0, 14.0, 13.0, 12.0, 11.0);
	__m256 c = _mm256_mul_ps(a, b);
	float d[8];
	_mm256_storeu_ps(d, c);

	printf("%s\n", "AVX Intrinsics (mul) on __m256:");
	for (int i = 0; i < 8; i++)
	{
		std::cout << d[i] << ' ';
	}
	printf("\n\n\n");





	
	// DVEC (AVX2) multiply (float 64)
	double advec[8] = { 8.54, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0 };
	double bdvec[8] = { 18.0, 17.0, 16.0, 15.0, 14.0, 13.0, 12.0, 11.0 };
	F64vec2 cdvec[8];
	for (int i = 0; i < 8; i++)
		cdvec[i] = (F64vec2)advec[i] * (F64vec2)bdvec[i];
	
	printf("%s\n", "DVEC (AVX2) (mul) on float64:");
	for (int i = 0; i < 8; i++)
	{
		printf("%4.2f ", cdvec[i]);
	}
	printf("\n\n\n");
	return 0;
}