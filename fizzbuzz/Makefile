name := fizzbuzz

bin: object
	ld -e start -o dist/$(name) dist/$(name).o
	chmod +x dist/$(name)

object: $(name).asm dist
	nasm -f elf64 $(name).asm -o dist/$(name).o

dist:
	mkdir dist

clean:
	rm dist -r

run: bin
	./dist/$(name)
