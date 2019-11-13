template <unsigned long N>
struct binary
{
  static unsigned const value = binary<N/10>::value *2 + N%10;
};

template <>
struct binary<0>
{
  static unsigned const value = 0;
};

int main(void)
{
  cout << "1010 : " << binary<1010>::value << endl;
  cout << "1110 : " << binary<1110>::value << endl;
  cout << "1011 : " << binary<1011>::value << endl;
}
 
#include <cstdlib>
#include <iostream>
#include <vector>
using namespace std;

// The class IntSwap<I,J> is a simple class containing a function 
// for swapping integers at indices I and J in an array if necessary 
template <int I, int J> class IntSwap {
public:
    static inline void compareAndSwap(int *data) {
      if ( data[I] > data[J] )
        swap( data[I], data[J]);
    }
};

// The class IntBubbleSortLoop<I,J> will swap the element at index J 
// with the element at index J+1 if necessary, then go on until it 
// reaches the end of the array, whose length is represented by I.
template <int I, int J> class IntBubbleSortLoop {
private:
    enum { go = ( J <= I-2 ) };
public:
    static inline void loop(int *data) {
      cout << "Loop " << I << " " << J << endl;
      IntSwap<J, J+1>::compareAndSwap(data);
      IntBubbleSortLoop< go ? I : 0, go ? (J+1) : 0 >::loop(data);
    }
};

template <> class IntBubbleSortLoop<0,0> {
public:
    static inline void loop(int *)  { }
};

// The class IntBubbleSort<N> is a class containing a function sort that 
// applys a bubble sort to a given array. 
template <int N> struct IntBubbleSort {
    static inline void sort(int *data) {
        IntBubbleSortLoop<N-1,0>::loop(data);
        IntBubbleSort<N-1>::sort(data);
    }
};

template <> struct IntBubbleSort<1> {
    static inline void sort(int *data) { }
};

int main(void) {
  int int_list[10] = {10,7,4,8,2,5,3,1,9,6};
  IntBubbleSort<10>::sort(int_list);

  for (int i=0; i<10; i++)
    cout << int_list[i] << ' ';
  cout << endl;
  return EXIT_SUCCESS;
}
 