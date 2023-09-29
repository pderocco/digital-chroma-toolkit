// QtUtil.h

#ifndef FILE_H
#define FILE_H

#include <QCoreApplication>
#include <QObject>
#include <QQuickItem>
#include <QByteArray>
#include <QString>
#include <QSysInfo>
#include <QVariant>
#include "build.h"

class QtUtil: public QObject, QSysInfo {

    Q_OBJECT

public:
    QtUtil(QObject* p = nullptr): QObject(p) {}

    Q_PROPERTY(QStringList args                   CONSTANT READ args)
    Q_PROPERTY(QByteArray bootUniqueId            CONSTANT READ bootUniqueId)
    Q_PROPERTY(QString    buildAbi                CONSTANT READ buildAbi)
    Q_PROPERTY(QString    buildCpuArchitecture    CONSTANT READ buildCpuArchitecture)
    Q_PROPERTY(int        buildDay                CONSTANT READ buildDay)
    Q_PROPERTY(int        buildHour               CONSTANT READ buildHour)
    Q_PROPERTY(int        buildMinute             CONSTANT READ buildMinute)
    Q_PROPERTY(int        buildMonth              CONSTANT READ buildMonth)
    Q_PROPERTY(int        buildSecond             CONSTANT READ buildSecond)
    Q_PROPERTY(int        buildYear               CONSTANT READ buildYear)
    Q_PROPERTY(QString    currentCpuArchitecture  CONSTANT READ currentCpuArchitecture)
    Q_PROPERTY(QString    kernelType              CONSTANT READ kernelType)
    Q_PROPERTY(QString    kernelVersion           CONSTANT READ kernelVersion)
    Q_PROPERTY(QString    machineHostName         CONSTANT READ machineHostName)
    Q_PROPERTY(QByteArray machineUniqueId         CONSTANT READ machineUniqueId)
    Q_PROPERTY(QString    prettyProductName       CONSTANT READ prettyProductName)
    Q_PROPERTY(QString    productType             CONSTANT READ productType)
    Q_PROPERTY(QString    productVersion          CONSTANT READ productVersion)

    QStringList           args()        const { return QCoreApplication::arguments(); }
    int                   buildDay()    const { return build_day; }
    int                   buildHour()   const { return build_hour; }
    int                   buildMinute() const { return build_minute; }
    int                   buildMonth()  const { return build_month; }
    int                   buildSecond() const { return build_second; }
    int                   buildYear()   const { return build_year; }

    Q_INVOKABLE void      clipSetText(QString data) const;
    Q_INVOKABLE bool      dirCreate(QString path) const;
    Q_INVOKABLE bool      fileExists(QString path) const;
    Q_INVOKABLE qint64    fileGetTime(QString path) const;
    Q_INVOKABLE QString   fileOSPath(QString path) const;
    Q_INVOKABLE QVariant  fileRead(QString path) const;
    Q_INVOKABLE bool      fileRemove(QString path) const;
    Q_INVOKABLE bool      fileRename(QString opath, QString npath) const;
    Q_INVOKABLE bool      fileSetTime(QString path, qint64 time) const;
    Q_INVOKABLE qint64    fileSize(QString path) const;
    Q_INVOKABLE QString   fileWrite(QString path, QByteArray data) const;
    };

#endif // FILE_H
