//
// CSc 256 Example 4.3: String length using function
// File: 4.3.cpp
// Name: William Hsu
// Date: 6/23/2010
// Description:  Computes length of string using str_len function
//
// Compile: g++ 4.3.cpp
// Run: ./a.out

#include <iostream>

using namespace std;

int str_len(char *);

int main() {
  char str[] = "abcde";
  int length;

  length = str_len(str);

  cout << length << endl;
}

int str_len(char *arg) {
  char *ptr;
  int count = 0;

  ptr = arg;
  while (*ptr != 0) {
    count++;
    ptr++;
  }
  return count;
}
