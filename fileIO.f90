MODULE FILEIANDO
CONTAINS
  SUBROUTINE PopMatrix_int(m)
    IMPLICIT NONE
    integer,dimension(100,100) :: m
    integer :: i,j
    call srand(314159)
    do i = 1,100,1 
       do j = 1, 100, 1
          m(i,j) = int(rand()*10)
       end do
    end do
  END SUBROUTINE PopMatrix_int

  SUBROUTINE PopMatrix_real(m)
    IMPLICIT NONE
    real,dimension(100,100) :: m
    integer :: i,j
    call srand(314159)
    do i = 1,100,1 
       do j = 1, 100, 1
          m(i,j) = int(rand()*100)/10.0
       end do
    end do
  END SUBROUTINE PopMatrix_real

  SUBROUTINE PrintMatrix_int(m)
    IMPLICIT NONE
    integer,dimension(100,100) :: m
    integer :: i, j
    character(LEN=20) :: format
    format = '(100I2, 2x)'
    do i = 1,100
       write(*,format) (m(i,j), j = 1, 100)
    end do
  END SUBROUTINE PrintMatrix_int
    

  SUBROUTINE PrintMatrix_real(m)
    IMPLICIT NONE
    real,dimension(100,100) :: m
    integer  :: i, j
    character(LEN=20) :: format
    format = '(100F4.1, 1x,a)'
    do i = 1,100
       write(6,format) (m(i,j), j = 1, 100 )
    end do
  END SUBROUTINE PrintMatrix_real    

  SUBROUTINE WriteToTxt_int(m)
    IMPLICIT NONE
    integer,dimension(100,100) :: m
    integer :: i, j
    open(unit=1, file='matrix_int.txt', status='unknown')
    do i = 1,100
       write(unit=1, fmt='(100I2)') (m(i,j),j=1,100)
    end do
    close(unit=1)
  END SUBROUTINE WriteToTxt_int

  SUBROUTINE WriteToTxt_real(m)
    IMPLICIT NONE
    real,dimension(100,100) :: m
    integer :: i, j
    open(unit=2, file='matrix_real.txt', status='unknown')
    do i = 1,100
       write(unit=2, fmt='(100f4.1)') (m(i,j),j=1,100)
    end do
    close(unit=2)
  END SUBROUTINE WriteToTxt_real

  SUBROUTINE WriteToBin_int(m)
    IMPLICIT NONE
    integer,dimension(100,100) :: m
    integer :: i,j
    open(3, file='matrix_int.dat', form = 'unformatted')
    do i = 1,100
       write(3) (m(i,j),j=1,100)
    end do
    close(3)
  END SUBROUTINE WriteTobin_int

  SUBROUTINE WriteToBin_real(m)
    IMPLICIT NONE
    real,dimension(100,100) :: m
    integer :: i,j
    open(4, file='matrix_real.dat', form = 'unformatted')
    do i = 1,100
       write(4) (m(i,j),j=1,100)
    end do
    close(4)
  END SUBROUTINE WriteToBin_real

  FUNCTION ReadFromBin_int(filename)
    IMPLICIT NONE
    character(14) :: filename
    integer,dimension(100,100) :: ReadFromBin_int
    integer,dimension(100,100) :: newmatrix
    integer :: i, j
    open(3, file = filename, form = 'unformatted')
    do i = 1,100
       read(3) (newmatrix(i,j), j = 1,100)
    end do
    close(3)
    ReadFromBin_int = newmatrix
  END FUNCTION ReadFromBin_int

  FUNCTION ReadFromBin_real(filename)
    IMPLICIT NONE
    character(15) :: filename
    real,dimension(100,100) :: ReadFromBin_real
    real,dimension(100,100) :: newmatrix
    integer :: i, j
    open(4, file = filename, form = 'unformatted')
    do i = 1,100
       read(4) (newmatrix(i,j), j = 1,100)
    end do
    close(4)
    ReadFromBin_real = newmatrix
  END FUNCTION ReadFromBin_real
END MODULE FILEIANDO

PROGRAM FILEIO
  USE FILEIANDO
  IMPLICIT NONE 
  integer,dimension(100,100) :: mat_int, readout_int
  real,dimension(100,100) :: mat_real, readout_real

  !Populate the two matrix
  print *,'Now populate 100x100 integer matrix ...'
  CALL PopMatrix_int(mat_int)
  print *,'Done!'
  print *,'Now populate 100x100 real matrix ..'
  CALL PopMatrix_real(mat_real)
  print *,'Done!'

  !Formated wirte out the matrix to screen
  print *,'The 100x100 integer matrix is :'
  CALL PrintMatrix_int(mat_int)
  print *,'Done!'
  print *,'The 100x100 real matrix is :'
  CALL PrintMatrix_real(mat_real)
  print *,'Done!'

  !Formated write out the matrix to txt file
  print *,'Now wirting integer matrix to txt file ...'
  CALL WriteToTxt_int(mat_int)
  print *,'Done!'
  print *,'Now wirting real matrix to txt file ...'
  CALL WriteToTxt_real(mat_real)
  print *,'Done!'

  !Write out the matrix to binary file
  print *,'Now writing integer matirx to binary file ...'
  CALL WriteToBin_int(mat_int)
  print *,'Done!'
  print *,'Now writing real matirx to binary file ...'
  CALL WriteToBin_real(mat_real)
  print *,'Done!'

  !Read out the matrix from binary file 
  print *,'Now reading integer matrix from binary file ...'
  readout_int = ReadFromBin_int('matrix_int.dat')
  print *,'Now reading integer matrix from binary file ...'
  readout_real = ReadFromBin_real('matrix_real.dat')

  !Print  matrix from binary file
  print *,'Now print out the integer matrix from binary file'
  CALL PrintMatrix_int(readout_int)
  print *,'Now print out the real matrix from binary file'
  CALL PrintMatrix_real(readout_real)

END PROGRAM FILEIO
