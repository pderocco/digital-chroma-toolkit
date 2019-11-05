#include <QGuiApplication>
#include <QLoggingCategory>
#include <QQmlApplicationEngine>
#include <QFont>
#include <QStyleHints>
#include "AudioInput.h"
#include "ChromaConverter.h"
#include "ChromaParser.h"
#include "HtmlResourceReader.h"
#include "ManchesterDecoder.h"
#if defined Q_OS_WIN
# include "MidiWin.h"
#elif defined Q_OS_MACOS
# include "MidiMac.h"
#elif defined Q_OS_LINUX
# include "MidiLin.h"
#else
# error Unknown OS
#endif
#include "QtUtil.h"
#include "TargetFileReader.h"
#include "UartReceiver.h"
#include "Utf8ResourceReader.h"
#include "WavReader.h"

int main(int argc, char* argv[]) {

    //QLoggingCategory::setFilterRules("default.warning=false");
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication::styleHints()->setMousePressAndHoldInterval(500);

    qmlRegisterType<AudioInput>("AudioInput", 1, 0, "AudioInput");
    qmlRegisterType<ChromaConverter>("ChromaConverter", 1, 0, "ChromaConverter");
    qmlRegisterType<ChromaParser>("ChromaParser", 1, 0, "ChromaParser");
    qmlRegisterType<HtmlResourceReader>("HtmlResourceReader", 1, 0, 
            "HtmlResourceReader");
    qmlRegisterType<ManchesterDecoder>("ManchesterDecoder", 1, 0, 
            "ManchesterDecoder");
    qmlRegisterType<Midi>("Midi", 1, 0, "Midi");
    qmlRegisterType<QtUtil>("QtUtil", 1, 0, "QtUtil");
    qmlRegisterType<TargetFileReader>("TargetFileReader", 1, 0, 
            "TargetFileReader");
    qmlRegisterType<UartReceiver>("UartReceiver", 1, 0, "UartReceiver");
    qmlRegisterType<Utf8ResourceReader>("Utf8ResourceReader", 1, 0, 
            "Utf8ResourceReader");
    qmlRegisterType<WavReader>("WavReader", 1, 0, "WavReader");

    QGuiApplication app(argc, argv);
    app.setOrganizationName("Hereford Software");
    app.setOrganizationDomain("dchroma.com");
    app.setApplicationName("Digital Chroma");
    app.setFont(QFont(QStringLiteral("Arial")));
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
    }
