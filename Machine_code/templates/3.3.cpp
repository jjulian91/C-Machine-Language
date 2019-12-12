//
// CSc 256 Example 3.3: String length
// File: 3.3.cpp
// Name: William Hsu
// Date: 6/18/2010
// Description:  Computes length of string
//
// Compile: g++ 3.3.cpp
// Run: ./a.out

#include <iostream>

using namespace std;

int main() {
  char str[] = "abcde";
  char *ptr;
  int count = 0;

  ptr = str;
  while (*ptr != 0) {
    count++;
    ptr++;
  }
  cout << count << endl;
}
