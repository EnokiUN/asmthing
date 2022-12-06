dist/hello: dist/hello.o
	ld -e start -o dist/hello dist/hello.o
	chmod +x dist/hello

dist/hello.o: hello.asm dist
	nasm -f elf64 hello.asm -o dist/hello.o

dist:
	mkdir dist

clean:
	rm dist -r

run: dist/hello
	./dist/hello
