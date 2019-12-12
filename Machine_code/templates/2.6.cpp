//
// CSc 256 Example 2.6: Logical operations
// Name: William Hsu
// Date: 6/18/2010
// Description:  User enters count. Program performs xor and shift right
//               operations, for count iterations. 
//
// Compile: g++ 2.6.cpp
// Run: ./a.out

#include <iostream>

using namespace std;

int main() {
  int count;
  int x = 0x89abcdef;

  cin >> count;

  for (int i=0; i<count; i++) {
    x = x ^ 0x00010002;
    cout << hex << x << endl;
    x = x >> 1;
  }
}
