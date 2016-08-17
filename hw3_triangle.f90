
MODULE MyTriangle
  IMPLICIT NONE

  TYPE RightTriangle
     real :: &
          side_a, &
          side_b, &
          hypotenuse, &
          angle_a, &
          angle_b, &
          angle_c, &
          area
     
  END TYPE RightTriangle
  
CONTAINS
  
  SUBROUTINE not_righttriangle(a,b,c)
    IMPLICIT NONE
    real :: a, b, c
    print *, a,b,c,'does not form a right triangle'
  END SUBROUTINE not_righttriangle

  SUBROUTINE is_righttriangle(T)
    IMPLICIT NONE
    type(rightTriangle) :: T
    real,parameter :: PI = 3.1415926
    T%angle_a = atan(T%side_a / T%side_b) * 180 / PI
    T%angle_b = atan(T%side_b / T%side_a) * 180 / PI
    T%angle_c = 90
    T%area = calcu_area(T%side_a, T%side_b)
    print *, 'Sides:', T%side_a, T%side_b
    print *, 'Hypotenuse:', T%hypotenuse
    print *, 'Angles:', T%angle_a, T%angle_b, T%angle_c
    print *, 'Area:', T%area
  END SUBROUTINE is_righttriangle

real FUNCTION  calcu_hypotenuse(a,b)
  IMPLICIT NONE
  real :: a, b
  calcu_hypotenuse = sqrt(a**2 + b**2)
END FUNCTION calcu_hypotenuse

real FUNCTION  calcu_area(a,b)
  IMPLICIT NONE 
  real :: a, b
  calcu_area = 0.5 * a * b
END FUNCTION calcu_area

END MODULE MyTriangle



PROGRAM Triangle_Fortran
 
  USE MyTriangle
  IMPLICIT NONE
  type(RightTriangle) :: Triangle


  print *, 'Enter a value for side a:'
  read *, Triangle%side_a

  print *, 'Enter a value for side b:'
  read *, Triangle%side_b

  print *, 'Enter a value for hypotenuse(0 to calculate):'
  read *, Triangle%hypotenuse

  if (Triangle%hypotenuse == 0.) then
     Triangle%hypotenuse = calcu_hypotenuse(Triangle%side_a, Triangle%side_b)
     call is_righttriangle(Triangle)
  elseif (calcu_hypotenuse(Triangle%side_a, Triangle%side_b) == Triangle%hypotenuse) then
     call is_righttriangle(Triangle)
  else
     call not_righttriangle(Triangle%side_a, Triangle%side_b, Triangle%hypotenuse)
  end if

END PROGRAM Triangle_Fortran




