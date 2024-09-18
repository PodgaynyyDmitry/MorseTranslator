#ifndef FILEHANDLER_H
#define FILEHANDLER_H

#include <QObject>
#include <QFile>
#include <QTextStream>
class fileHandler: public QObject {
Q_OBJECT
public:
    explicit fileHandler(QObject * parent = nullptr);
    Q_INVOKABLE QString readText(QString filePath);
    Q_INVOKABLE void save(QString filePath,QString text);
private:
};

#endif // FILEHANDLER_H
