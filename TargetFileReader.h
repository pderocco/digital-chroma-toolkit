// TargetFileReader.h

#ifndef TARGETFILEREADER_H
#define TARGETFILEREADER_H

#include <QObject>
#include <QString>
#include <QVariant>

class TargetFileReader: public QObject {

    Q_OBJECT

public:

    explicit TargetFileReader(QObject* p = nullptr): QObject(p) {}

    Q_INVOKABLE QVariant read(QString p);
    };

#endif // TARGETFILEREADER_H
