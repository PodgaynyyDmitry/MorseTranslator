#ifndef FILEHANDLER_H
#define FILEHANDLER_H

#include <QObject>
#include <QFile>
#include <QTextStream>
class FileHandler : public QObject
{
    Q_OBJECT
public:
    explicit FileHandler(QObject *parent = nullptr);
    Q_INVOKABLE QString readText(QString filePath);
    Q_INVOKABLE void saveText(QString filePath, QString text);
};
#endif // FILEHANDLER_H
