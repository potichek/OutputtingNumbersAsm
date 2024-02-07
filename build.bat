nasm -f win64 main.asm -o main.o
nasm -f win64 arraylist.asm -o arraylist.o
ld main.o arraylist.o -o main.exe -l kernel32 -l user32
main.exe