.PHONY : all
all : c2-echo.so c2-command-line.so c2-echo-app.so
c2-echo.so : c2-echo.sh
	echo '(compile-script "c2-echo.sh")' | scheme -q
c2-command-line.so : c2-command-line.sh
	echo '(compile-script "$^")' | scheme -q
c2-echo-app.so : c2-echo-app.sh
	echo '(compile-program "$^")' | scheme -q --optimize-level 3

.PHONY : clean
clean :
	@rm -f *.so
