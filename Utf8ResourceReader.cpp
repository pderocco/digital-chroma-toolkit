// Utf8ResourceReader.cpp

#include "Utf8ResourceReader.h"
#include <QTextStream>
#include <QByteArray>
#include <QResource>

/* bool Utf8ResourceReader::resourceExists(QString url); ----------------------
This returns true if there is a resource called url.                         */

bool Utf8ResourceReader::resourceExists(QString url) {

    return QResource(url).isValid();
    }

/* void Utf8ResourceReader::setUrl(QString const& url); -----------------------
If the url differs from m_url, it records it in m_url, signals the change, and 
attempts to open the resource. If successful, it reads it as UTF-8 into m_text; 
if unsuccessful, it clears m_text. It emits the textChanged signal if m_text 
changes.                                                                     */

void Utf8ResourceReader::setUrl(QString const& url) {

    // If url changes, record change, emit signal.
    if (m_url != url) {
        m_url = url;
        emit urlChanged(m_url);

        // Attempt to open resource. If successful...
        QString text;
        QResource res(url);
        if (res.isValid()) {

            // Copy or decompress into byte array.
            QByteArray ba;
            if (res.isCompressed())
                ba = qUncompress(res.data(), res.size());
            else
                ba.append(reinterpret_cast<char const*>(res.data()), 
                        res.size());

            // Read as UTF-8.
            QTextStream ts(ba);
            ts.setCodec("UTF-8");
            text = ts.readAll();
            }

        // If text changes, record change, emit signal.
        if (m_text != text) {
            m_text = text;
            emit textChanged(m_text);
            }
        }
    }
