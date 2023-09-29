// TargetFileReader.cpp

#include <QByteArray>
#include <QResource>
#include "TargetFileReader.h"

QVariant TargetFileReader::read(QString p) {
    QResource f(p);

    // If no resource, return null.
    if (!f.isValid())
        return QVariant();

    // Create array large enough for Sysex header, file contents, EOX.
    int n = f.size();
    QByteArray a(n + 6, 0);

    // Fill in header, read file, fill in EOX.
    char* d = a.data();
    d[0] = char(0xF0);
    d[1] = 0;
    d[2] = 0;
    d[3] = 0x14;
    d[4] = 'D';
    memcpy(&d[5], f.data(), n);
    d[n + 5] = char(0xF7);

    // Return array.
    return a;
    }
