# Java tools
JAVAHOME=/home/daluai/.sdkman/candidates/java/current
JAVAC=$(JAVAHOME)/bin/javac
JAR=$(JAVAHOME)/bin/jar
JAVA=$(JAVAHOME)/bin/java
JAVADOC=$(JAVAHOME)/bin/javadoc

# C compiler
GCC=gcc
GCCFLAGS=-shared -I$(JAVAHOME)/include -I$(JAVAHOME)/include/linux -fPIC

# Paths
CLASSPATH=./classes:.

default: jar native docs

java:
	$(JAVAC) -encoding ISO-8859-1 -classpath $(CLASSPATH) -d ./classes `find ./src/jcurses -name *.java`

docs:
	$(JAVADOC) -encoding ISO-8859-1 -classpath $(CLASSPATH) -sourcepath ./src -d ./doc jcurses.event jcurses.system jcurses.util jcurses.widgets

include: java
	$(JAVAHOME)/bin/javac -d ./src/native/include -cp classes src/jcurses/system/Toolkit.java -Xlint:unchecked

native: java include
	$(GCC) $(GCCFLAGS) -o lib/libjcurses.so $(CURSES) src/native/Toolkit.c -lncurses

jar: java
	cd classes/ && $(JAR) -cvf ../lib/jcurses.jar *

clean:
	rm -rf ./classes/* ./lib/*

test:
	$(JAVA) -classpath ./lib/jcurses.jar -Djcurses.protocol.filename=jcurses.log jcurses.tests.Test
