# Generated automatically from Makefile.in by configure.
CURSES=-lncurses
JAVAHOME=/home/daluai/.sdkman/candidates/java/current
JAVAC=$(JAVAHOME)/bin/javac
JAR=$(JAVAHOME)/bin/jar
JAVAH=$(JAVAHOME)/bin/javah
JAVA=$(JAVAHOME)/bin/java
JAVADOC=$(JAVAHOME)/bin/javadoc
GCC=gcc
GCCFLAGS=-Wall -shared -I$(JAVAHOME)/include -I$(JAVAHOME)/include/linux -fPIC
CLASSPATH=./classes

default: jar native docs
java: ;$(JAVAC) -encoding ISO-8859-1 -classpath $(CLASSPATH) -d  ./classes `find ./src/jcurses -name *.java`
docs: ;$(JAVADOC) -encoding ISO-8859-1 -Xdoclint:none -classpath $(CLASSPATH) -sourcepath ./src -d ./doc jcurses.event jcurses.system jcurses.util jcurses.widgets
native: java include
include: java;$(JAVAH) -encoding ISO-8859-1 -classpath ./src -d ./src/native/include jcurses.system.Toolkit
clean: ;rm -rf ./classes/jcurses ./lib/libjcurses.so ./lib/jcurses.jar ./src/native/include/*.h && find ./doc/* | grep -vi "overview.html" | xargs rm -rf
native:java include;$(GCC) $(GCCFLAGS) -o lib/libjcurses.so $(CURSES) src/native/Toolkit.c -lncurses
jar: java;cd classes/ && $(JAR) -cvf ../lib/jcurses.jar *
test: ;$(JAVA) -classpath ./lib/jcurses.jar -Djcurses.protocol.filename=jcurses.log jcurses.tests.Test


