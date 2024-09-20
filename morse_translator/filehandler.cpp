#include "filehandler.h"

FileHandler::FileHandler(QObject *parent): QObject (parent)
{

}
QString FileHandler::readText(QString filePath)
{
    QString result;
    QFile file(filePath);
    if(!file.open(QIODevice::ReadOnly|QIODevice::Text))
        return "Не удалось открыть файл";
    QTextStream in(&file);
    result=in.readAll();
    file.close();
    return result;
}
void FileHandler::save(QString filePath, QString text)
{
    QFile file(filePath);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
        return;
    QTextStream out(&file);
    out<< text;
    file.close();
}
