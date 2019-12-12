//
// CSc 256 Example 3.4: Integer array
// File: 3.4.cpp
// Name: William Hsu
// Date: 6/21/2010
// Description:  Initializes integer array using pointers
//
// Compile: g++ 3.4.cpp
// Run: ./a.out

#include <iostream>

using namespace std;

int main() {
  int x[6];
  int *ptr;
  int i;

  ptr = x;
  for (i=0; i<6; i++) {
    x[i] = i;
    ptr++;
  }
  ptr = x;
  for (i=0; i<6; i++) {
    cout << *ptr << endl;
    ptr++;
  }
}
