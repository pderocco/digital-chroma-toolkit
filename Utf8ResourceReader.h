// Utf8ResourceReader.h

#ifndef UTF8RESOURCEREADER_H
#define UTF8RESOURCEREADER_H

#include <QObject>
#include <QQuickItem>
#include <QString>

class Utf8ResourceReader: public QObject {

    Q_OBJECT
    Q_PROPERTY(QString text  NOTIFY textChanged  READ getText)
    Q_PROPERTY(QString url   NOTIFY urlChanged   READ getUrl  WRITE setUrl)

    QString     m_text;
    QString     m_url;

public:

    explicit    Utf8ResourceReader(QObject* p = nullptr): QObject(p) {}
    QString     getText() const { return m_text; }
    QString     getUrl() const { return m_url; }

    Q_INVOKABLE
    bool        resourceExists(QString url);

public slots:
    void        setUrl(QString const& url);

signals:
    void        textChanged(QString const& text);
    void        urlChanged(QString const& url);
    };

#endif // UTF8RESOURCEREADER_H
