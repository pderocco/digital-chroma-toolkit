// QtUtil.cpp

#include <QClipboard>
#include <QDateTime>
#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QGuiApplication>
#include "QtUtil.h"

/* void QtUtil::clipSetText(QString data) const; ------------------------------
This places the specified string onto the system clipboard as plain text.    */

void QtUtil::clipSetText(QString data) const {

    QGuiApplication::clipboard()->setText(data, QClipboard::Clipboard);
    }

/* bool QtUtil::dirCreate(QString path) const; --------------------------------
This creates a directory of the specified name, and returns true if 
successful or if it already existed.                                         */

bool QtUtil::dirCreate(QString path) const {

    return QFileInfo(path).isDir() || QDir().mkdir(path);
    }

/* bool QtUtil::fileExists(QString path) const; -------------------------------
This returns true if the file specified by path exists.                      */

bool QtUtil::fileExists(QString path) const {

    return QFile::exists(path);
    }

/* qint64 QtUtil::fileGetTime(QString path) const; ----------------------------
This returns the last modified time of the file specified by path (in ms since 
1970), or -1 if it doesn't exist.                                            */

qint64 QtUtil::fileGetTime(QString path) const {
    QFile f(path);

    if (!f.exists())
        return -1;
    return f.fileTime(QFileDevice::FileModificationTime).toMSecsSinceEpoch();
    }

/* QString QtUtil::fileOSPath(QString path) const; ----------------------------
This converts a pathname path to an OS pathname. On Windows, it uses backslash 
as the path separator.                                                       */

QString QtUtil::fileOSPath(QString path) const {

    if (QSysInfo::productType() == "windows")
        path = path.replace('/', '\\');
    return path;
    }

/* QVariant QtUtil::fileRead(QString path) const; -----------------------------
This opens the file of the specified path, reads its contents, and returns it 
as a QByteArray. If the file doesn't exist, it returns an empty QString. If it 
can't open the file, it returns "can't open". If it is too big to return in a 
QByteArray, it returns "oversized". If it can't read all the data, it returns 
"can't read". Otherwise, it returns a QByteArray containing all the data.    */

QVariant QtUtil::fileRead(QString path) const {

    if (!QFile::exists(path))
        return "";
    QFile f(path);
    if (!f.open(QIODevice::ReadOnly))
        return "can't open";
    qint64 n = f.size();
    if (n > 0x7FFFFFFF)
        return "oversized";
    QByteArray v = f.readAll();
    if (v.size() != n)
        return "can't read";
    return v;
    }

/* bool QtUtil::fileRemove(QString path) const; -------------------------------
This removes the file specified by path if it exists, and returns true if it 
successfully removes it or it didn't exist, false if an error occurred.      */

bool QtUtil::fileRemove(QString path) const {

    return QFile::exists(path) ? QFile::remove(path) : true;
    }

/* bool QtUtil::fileRename(QString opath, QString npath) const; ---------------
If the file specified by opath exists, it renames it to npath, returning true 
if successful, false if an error occurs (including npath already existing). If 
opath doesn't exist, it acts like remove(npath).                             */

bool QtUtil::fileRename(QString opath, QString npath) const {

    return QFile::exists(opath) ? QFile::rename(opath, npath) 
            : QFile::remove(npath);
    }

/* bool QtUtil::fileSetTime(QString path, qint64 time) const; -----------------
This sets the last modified time on the specified path to time (in ms since 
1970), and returns true if successful, false on any error.                   */

bool QtUtil::fileSetTime(QString path, qint64 time) const {
    QDateTime d;

    d.setMSecsSinceEpoch(time);
    return QFile(path).setFileTime(d, QFileDevice::FileModificationTime);
    }

/* qint64 QtUtil::fileSize(QString path) const; -------------------------------
This returns the size of the file specified by path, or -1 if it doesn't 
exist.                                                                       */

qint64 QtUtil::fileSize(QString path) const {
    QFile f(path);

    return f.exists() ? f.size() : -1;
    }

/* QString QtUtil::fileWrite(QString path, QByteArray data) const; ------------
This creates the file of the specified path, and writes data to it, overwriting 
any previous contents. If it can't create the file, it returns "can't create", 
if it gets a write error, it returns "can't write", and otherwise returns an 
empty string.                                                                */

QString QtUtil::fileWrite(QString path, QByteArray data) const {
    QFile f(path);

    if (!f.open(QIODevice::WriteOnly))
        return "can't create";
    else if (f.write(data.data(), data.size()) < 0)
        return "can't write";
    else
        return "";
    }
