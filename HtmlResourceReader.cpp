// HtmlResourceReader.cpp

#include <QResource>
#include <QTextStream>
#include "HtmlResourceReader.h"

/* explicit HtmlResourceReader::HtmlResourceReader(QObject* p = nullptr); -----
This connects the textChange signals in the subsidiary Utf8ResourceReader 
objects to the appropriate private slots.                                    */

HtmlResourceReader::HtmlResourceReader(QObject* p): QObject(p) {

    connect(&m_default, &Utf8ResourceReader::textChanged, 
            this, &HtmlResourceReader::setDefaultText);
    connect(&m_html, &Utf8ResourceReader::textChanged, 
            this, &HtmlResourceReader::setHtmlText);
    connect(&m_style, &Utf8ResourceReader::textChanged, 
            this, &HtmlResourceReader::setStyleText);
    }

/* bool HtmlResourceReader::resourceExists(QString url); ----------------------
This returns true if there is a resource called url.                         */

bool HtmlResourceReader::resourceExists(QString url) {

    return QResource(url).isValid();
    }

/* void HtmlResourceReader::setDefaultText(QString const& text); --------------
This private slot is connected to the textChanged signal of m_default. If the 
text of m_html is empty, this recomputes m_text.                             */

void HtmlResourceReader::setDefaultText(QString const&) {

    if (!m_html.getText().size())
        textSet();
    }

/* void HtmlResourceReader::setDefaultUrl(QString const& url); ----------------
This sets the url property of m_default to url.                              */

void HtmlResourceReader::setDefaultUrl(QString const& url) {

    m_default.setUrl(url);
    }

/* void HtmlResourceReader::setHtmlText(QString const& text); -----------------
This private slot is connected to the textChanged signal of m_html. It 
recomputes m_text.                                                           */

void HtmlResourceReader::setHtmlText(QString const&) {

    textSet();
    }

/* void HtmlResourceReader::setHtmlUrl(QString const& url); -------------------
This sets the url property of m_html to url.                                 */

void HtmlResourceReader::setHtmlUrl(QString const& url) {

    m_html.setUrl(url);
    }

/* void HtmlResourceReader::setStyleText(QString const& text); ----------------
This private slot is connected to the textChanged signal of m_style. It 
recomputes m_text.                                                           */

void HtmlResourceReader::setStyleText(QString const&) {

    textSet();
    }

/* void HtmlResourceReader::setStyleUrl(QString const& url); ------------------
This sets the url property of m_style to url.                                */

void HtmlResourceReader::setStyleUrl(QString const& url) {

    m_style.setUrl(url);
    }

/* QString& HtmlResourceReader::textSet(); ------------------------------------
This private function sets m_text to m_style concatenated with m_html, or with 
m_default if m_html is empty, and emits the textChanged signal if it actually 
changes.                                                                     */

QString& HtmlResourceReader::textSet() {
    QString s, t;

    // Extract base name from URL into t.
    int i = m_html.getUrl().lastIndexOf('/') + 1;
    int j = m_html.getUrl().indexOf('.', i);
    if (j < 0)
        j = m_html.getUrl().size();
    t = m_html.getUrl().mid(i, j - i);

    // If there is no HTML...
    if (!m_html.getText().size()) {

        // Copy default HTML, replace "$URL$" with missing URL.
        s = m_default.getText();
        s.replace(QStringLiteral(u"$URL$"), m_html.getUrl());
        }

    // If HTML found, use it.
    else
        s = m_html.getText();

    // Scan HTML for <title> element, use instead of URL base name if found.
    i = s.indexOf(QStringLiteral(u"<title>"));
    if (i >= 0) {
        i += 7;
        int j = s.indexOf(QStringLiteral(u"</title>"), i);
        if (j > i) {
            j -= i;
            if (j <= 30)
                t = s.mid(i, j).trimmed();
            }
        }

    // Set title, signal change.
    if (m_title != t)
        emit titleChanged(m_title = t);

    // Set m_text to style plus HTML, signal change.
    s = "<style>\n" + m_style.getText() + "</style>\n" + s;
    if (m_text != s)
        emit textChanged(m_text = s);

    //  Return text.
    return m_text;
    }
