//
// CSc 256 Example 10.1: Floating point
// File: 10.1.cpp
// Name: William Hsu
// Date: 7/7/2010
// Description:  reads in two arrays of floats x[] and y[]
//               if (x[i] > y[i])
//                 x[i] = x[i] + y[i];
//               print x[]
// Compile: g++ 10.1.cpp
// Run: ./a.out

#include <iostream>
using namespace std;

int main()
{
  int i;
  float x[5], y[5];

  cout << "Enter 5 elements for x[]:\n";
  for (i=0;i<5;i++)
    cin >> x[i]; 

  cout << "Enter 5 elements for y[]:\n";
  for (i=0;i<5;i++)
    cin >> y[i]; 

  for (i=0;i<5;i++)
    if (x[i] > y[i])
      x[i] = x[i] + y[i]; 

  cout << "\nElements of x[] are:\n";
  for (i=0;i<5;i++)
    cout << x[i] << endl;

  return 0;
}

