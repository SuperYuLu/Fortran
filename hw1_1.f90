! Homework to calculate the sum of 
! the first 50 of 1, 3, 5, ... 
program hw1_1

integer, parameter :: &
     n = 50 , &
     a = 1 , &
     d = 2 

integer :: sumN

sumN = a*n + n * ( n - 1 ) * d / 2

print *, 'sumN =', sumN 

end program 

