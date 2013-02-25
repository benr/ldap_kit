
all: ns1
	gcc -I . -c ns_crypt.c 
	gcc -I . -c ns1.c 
	gcc -o ns1 ns_crypt.o ns1.o 
	rm -f ns_crypt.o ns1.o

clean:
	rm -f ns1.o ns_crypt.o ns1
