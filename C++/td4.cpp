#include <iostream>
#include <cstdlib>
#include <vector>
using namespace std;

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

