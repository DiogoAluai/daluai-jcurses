JCurses - a java console windowing toolkit for Windows and Linux
=================================================================

---

(Diogo Aluai) Aug 2025 - Installation
--------
A `final.sh` script is provided to fully build the project (maven install, make, and prompt to install libjcurses.so).

However, this final script requires [sdkman](https://sdkman.io/), and java 8.0.462-amzn:
```bash
# install sdkman following their website's instructions
sdk java install 8.0.462-amzn
sdk java install 17.0.13-amzn && sdk java use 17.0.13-amzn # example of currently using different java version
./final.sh
```



---

Preamble
--------

The Java Curses Library is a library that makes is possible to create
text- based terminal applications in the Java programming language,
like curses under Unix.  For this purpose a windowing toolkit is
implemented, that, like AWT, consists of many classes for text based
windows and GUI elements, that are layouted within these windows. An
application,that bases on the library, creates one or more of this
windows and reacts on events coming by user interactions with GUI
elements.

Environment
-----------

The Java Curses Library consists of two parts: the plattform
independent part, that contains Java classes, used writing applicatons
and plattform dependent part, that consists of a native shared library
making primitive input and output operations available to the first
part.  The first part comes as a jar file (jcurses.jar) the second
part as a shared library ( libjcurses.so under Linux, libjcurses.dll
under Win32 ).  The Library is developed und tested with Linux und
Windows 2000 und Windows 95, other UNIX plattforms must be easy to
port, because the autoconf is used to create the makefile.

 To use the library following is required: 
 a) You must use JDK at or above 1.2
 b) A curses implementation must be installed, if it is a UNIX OS
 c) The jcurses.jar must be in the CLASSPATH
 d) The shared library built by Java Curses must be in the same
    directory as jcurses.jar

Installation
------------

### Binary Distribution

The binary distribution comes already compiled for the specified plattform,
it contains the library ( jcurses.jar and libjcurses.XXX ) in the lib
directory and the Java documentation in the javadoc directory.

### Source Distribution

The Source distribution is to use under UNIX plattforms other as Linux.
To compile the library following conditions are required:

1. A JDK at or above version 1.2 must be installed and be in the PATH
2. GCC must be installed and be in the PATH

Steps to compile the library:

1. Change to the distribution directory
2. ./configure
3. make all (the default target is just to make the shared C library)

To use the compiled library see [Installation](#installation).
