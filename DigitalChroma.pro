QT += multimedia qml quick
CONFIG += c++17 static

SOURCES += main.cpp \
    AudioInput.cpp \
    build.cpp \
    ChromaConverter.cpp \
    ChromaParser.cpp \
    HtmlResourceReader.cpp \
    ManchesterDecoder.cpp \
    MidiBase.cpp \
    QtUtil.cpp \
    TargetFileReader.cpp \
    UartReceiver.cpp \
    Utf8ResourceReader.cpp \
    WavReader.cpp \

windows:    SOURCES += MidiWin.cpp
macx:       SOURCES += MidiMac.cpp
unix:!macx: SOURCES += MidiLin.cpp

HEADERS += \
    AudioInput.h \
    build.h \
    ChromaConverter.h \
    ChromaParser.h \
    HtmlResourceReader.h \
    ManchesterDecoder.h \
    MidiBase.h \
    QtUtil.h \
    TargetFileReader.h \
    UartReceiver.h \
    Utf8ResourceReader.h \
    WavReader.h \

windows:    HEADERS += MidiWin.h
macx:       HEADERS += MidiMac.h
unix:!macx: HEADERS += MidiLin.h

windows:    QTPLUGIN.audio = qtaudio_windows

RESOURCES += qml.qrc help\help.qrc

# Platform configuration
windows:DEFINES     += __WINDOWS_MM__
windows:LIBS        += -lWINMM
windows:RC_ICONS    = images/icon-wrenches.ico
macx:DEFINES        += __MACOSX_CORE__
macx:LIBS           +=  -framework CoreMIDI -framework CoreFoundation -framework CoreAudio
macx:ICON           = images/icon-wrenches.icns
unix:!macx:DEFINES  += __LINUX_ALSASEQ__
unix:!macx:LIBS     += -lasound -lpthread

# Default rules for deployment
unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

# Force build.cpp to be recompiled every time
buildd.target = debug/build.obj
buildd.CONFIG = phony
build.target = release/build.obj
build.CONFIG = phony

# Make dependent on resource files
qml_scenes.depends = \
    $$PWD/emu/*/* \
    $$PWD/help/* \
    $$PWD/help/images/* \
    $$PWD/images/* \
    $$PWD/qml/* \

qml_scenes.commands =

QMAKE_EXTRA_TARGETS += qml_scenes buildd build

DISTFILES +=
