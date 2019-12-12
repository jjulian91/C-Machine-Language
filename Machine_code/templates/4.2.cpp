//
// CSc 256 Example 4.2: Poly function
// File: 4.2.cpp
// Name: William Hsu
// Date: 6/22/2010
// Description:  Computes x^4 + x^3 + 1, for x = 2 to 4
//
// Compile: g++ 4.2.cpp
// Run: ./a.out

#include <iostream>
using namespace std;

int poly(int);
int pow(int, int);

int main() {
  int i;
  int result;

  for (i=2; i<=4; i++) {
    result = poly(i);
    cout << result << endl;
  }
}

int poly(int arg) {
  int temp1, result;
  temp1 = pow(arg, 4);
  result = pow(arg, 3);
  result = temp1 + result + 1;
  return result;
}

int pow(int arg0, int arg1) {
  int product = 1;
  for (int i=0; i<arg1; i++) {
    product *= arg0;
  }
  return product;
}
