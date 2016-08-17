!Calculate the energy of input mass
!according to Einstein function 


program hw1_2

real*8 :: M, E
real*8, parameter :: c = 299792458

print *, 'In put the value of Mass, M = '
read *, M

E = M * c ** 2

print *, 'The energy of your input mass is E = ' , E

end program 
