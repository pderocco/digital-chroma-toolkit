This is a program manager and editor for the Digital Chroma synthesizer. It is 
written in QML and Qt, and is configured for building in Qt Creator 4.10.0, 
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

If you are using a Mac, it should be possible to create a version of helpcomp 
in Xcode, by using the source code found in the digital-chroma-helpcomp repo, 
although I've never tried it, so it may cough up some errors that need 
massaging.

Bug reports to: bugs@digitalchroma.com
