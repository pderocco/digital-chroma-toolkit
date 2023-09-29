DIGITAL CHROMA TOOLKIT

This is a program manager and editor for the Digital Chroma synthesizer. It is 
written in QML and Qt, and is configured for building in Qt Creator 5.15.1
using Microsoft Visual Studio 2017. It has also been successfully compiled on 
the Mac using Xcode. When you've successfully built it and run it, it contains 
full help documentation that explains how it works, as well as how the 
instrument itself works.

Before this can be compiled, the help files contained in the helpsrc directory 
must be compiled into HTML files or HTML fragments using the helpcomp program. 
This is provided as a Windows command line executable in the root directory of 
this repo, which is to be run from that directory using the command:

    helpcomp helpsrc help helphtml

This should translate the existing files in the helpsrc directory into HTML 
fragments in the help directory, which get included as resources in the 
Toolkit executable, and full HTML files in the helphtml directory, which you 
can view in a web browser. Some harmless warnings will result. The 
helphtml\index.html file lets you view the help pages individually, while 
helphtml\master.html gives you one huge page suitable for doing global 
searches.

Be aware, though, that some versions of Firefox won't follow links in local 
files unless you first go into about:config and set the 
security.fileuri.strict_origin_policy variable to false. There may be similar 
issues in other browsers.

Once the help files are compiled, you can build the entire Toolkit in Qt 
Creator. If you ever create, delete, or rename help files, you must run qmake 
before rebuilding the Toolkit.

If you are using a Mac, it should be possible to create an Xcode project that 
compiles helpcomp.cpp, if you have the latest Xcode that has the <filesystem> 
header and associated library support. The source code can be found in the 
digital-chroma-helpcomp repo. If you can't get this to work, you'll at least 
need to run helpcomp.exe on a Windows machine to compile the help files, and 
then copy them over to the Mac.

CREATING A STANDALONE EXECUTABLE

To do this, you have to build Qt static libraries. On Windows, using VS2017, 
you have to use the "Developer Command Prompt for VS 2017", which sets up the 
environment. The commands I've used to build the libraries on Windows are:

    set path=%path%;C:\Qt\Qt5.15.1\Tools\QtCreator\bin
    configure.bat -prefix "C:\Qt\Qt5.15.1\5.15.1\msvc2017s" -release -platform win32-msvc -confirm-license -opensource -nomake examples -nomake tests -static -no-feature-d3d12
    nmake
    nmake install

without the line breaks. On the Mac, you can use an ordinary terminal window, 
and use:

    ./configure -prefix /opt/Qt5.15.1/5.15.1/clang_64s -release -confirm-license -opensource -nomake examples -nomake tests -static
    make
    make install

Obviously, the directories will differ if you installed Qt somewhere else.

Once you have these static libraries, you have to add the following 
subdirectory to the start of the path, so that the static versions of the tools 
will be used to build the Toolkit:

    C:\Qt\Qt5.15.1\5.15.1\msvc2017s\bin (on Windows)
    /opt/Qt5.15.1/5.15.1/clang_64s/bin (on Mac)

Then you can go into the directory containing the Toolkit source, and type:

    qmake DigitalChroma.pro
    nmake release (on Windows)
    make release (on Mac)

You should wind up with DigitalChroma.exe or DigitalChroma.app in the current 
directory.

Bug reports to: bugs@digitalchroma.com
