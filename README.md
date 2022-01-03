# Calculator made with flex and bison.
  Works with the following mathematical operations: addition, substraction, multiplication, division, power.
  
  It also recongnizez brackets.
  
  Recognizes both integers and floats.
  

# How to run it
  First of all, make sure to have it installed. Then run the following.
  
  For linux:
  ```
  flex calculator.l
  bison -d calculator.y
  cc calculator.tab.c lex.yy.c -lfl -o calculator.out -lm
  ./calculator.out
  ```
  
  For windows:
  ```
  flex calculator.l
  bison -d calculator.y
  gcc lex.yy.c calculator.tab.c
  a.exe
  ```
