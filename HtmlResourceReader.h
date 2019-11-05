// HtmlResourceReader.h

#ifndef HTMLRESOURCEREADER_H
#define HTMLRESOURCEREADER_H

#include <QObject>
#include <QQuickItem>
#include <QString>
#include "Utf8ResourceReader.h"

class HtmlResourceReader: public QObject {

    Q_OBJECT
    Q_PROPERTY(QString defaultUrl NOTIFY defaultUrlChanged READ getDefaultUrl WRITE setDefaultUrl)
    Q_PROPERTY(QString htmlUrl    NOTIFY htmlUrlChanged    READ getHtmlUrl    WRITE setHtmlUrl)
    Q_PROPERTY(QString styleUrl   NOTIFY styleUrlChanged   READ getStyleUrl   WRITE setStyleUrl)
    Q_PROPERTY(QString text       NOTIFY textChanged       READ getText)
    Q_PROPERTY(QString title      NOTIFY titleChanged      READ getTitle)

    Utf8ResourceReader  m_default;
    Utf8ResourceReader  m_html;
    Utf8ResourceReader  m_style;
    QString             m_text;
    QString             m_title;

    QString             read(QString const& url);
    QString&            textSet();

public:

    explicit    HtmlResourceReader(QObject* p = nullptr);
    QString     getDefaultUrl() const { return m_default.getUrl(); }
    QString     getHtmlUrl() const { return m_html.getUrl(); }
    QString     getStyleUrl() const { return m_style.getUrl(); }
    QString     getText() const { return m_text; }
   QString     getTitle() const { return m_title; }

    Q_INVOKABLE
    bool        resourceExists(QString url);

private slots:
    void        setDefaultText(QString const& text);
    void        setHtmlText(QString const& text);
    void        setStyleText(QString const& text);

public slots:
    void        setDefaultUrl(QString const& dc);
    void        setHtmlUrl(QString const& r);
    void        setStyleUrl(QString const& r);

signals:
    void        defaultUrlChanged(QString const& url);
    void        htmlUrlChanged(QString const& url);
    void        styleUrlChanged(QString const& url);
    void        textChanged(QString const& text);
    void        titleChanged(QString const& title);
    };

#endif // HTMLRESOURCEREADER_H
