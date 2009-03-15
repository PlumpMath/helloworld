TARGET = hello-lisp

all: hello-c hello-cc hello-hs hello-lisp HelloWorld.class
	@echo "C"; average -n 20 ./hello-c > /dev/null
	@echo "C++"; average -n 20 ./hello-cc > /dev/null
	@echo "Haskell (compiled)"; average -n 20 ./hello-hs > /dev/null
	@echo "Perl"; average -n 20 ./hello.pl > /dev/null
	@echo "Ruby (1.8.7)"; average -n 20 ./hello.rb > /dev/null
	@echo "Ruby (1.9.1-p0)"; average -n 20 ruby1.9 ./hello.rb > /dev/null
	@echo "Python"; average -n 20 ./hello.py > /dev/null
	@echo "ECL (Common Lisp)"; average -n 20 ./hello-lisp > /dev/null
	@echo "Java (JDK6)"; average -n 20 java -cp . HelloWorld > /dev/null
	@echo "Haskell (interpreted)"; average -n 20 runhaskell ./hello-hs.hs > /dev/null
	@echo "Groovy (JDK6)"; average -n 20 ./hello.groovy > /dev/null

hello-c: hello-c.o
	gcc -o $@ $?

hello-cc: hello-cc.o
	g++ -o $@ $?

hello-hs: hello-hs.hs
	ghc --make $?

$(TARGET): $(TARGET).o
	ecl -o $@ -link \
		$(HOME)/Library/Lisp/site/series/s-package.o \
		$(HOME)/Library/Lisp/site/series/s-code.o \
		$?

$(TARGET).o: $(TARGET).lisp
	ecl -s -load $(HOME)/Library/Lisp/init.lisp \
		-eval "(load-or-install :series)" -compile $?

$(TARGET).class: $(TARGET).java
	javac $?

clean:
	rm -f $(TARGET) $(TARGET).o $(TARGET).fas
