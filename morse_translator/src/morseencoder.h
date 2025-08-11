#ifndef MORSEENCODER_H
#define MORSEENCODER_H

#include <QObject>
#include <QMap>
#include <QHash>

const QString SPACE = " ";
const QString EMPTY = "";
const QString DOUBLE_SPACE = "  ";

class MorseEncoder : public QObject
{
    Q_OBJECT

public:
    explicit MorseEncoder(QObject *parent = nullptr);
    Q_INVOKABLE QString encode(QString text);
    Q_INVOKABLE QString decode(QString text);

private:
    QHash<QChar, QString> encoder;
    QMap<QString, QChar> decoder;
};

#endif // MORSEENCODER_H
