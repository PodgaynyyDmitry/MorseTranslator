#include "filehandler.h"

fileHandler::fileHandler(QObject * parent):QObject(parent){}
QString fileHandler:: readText(QString filePath)
{
    QString result;
    QFile file(filePath);
    if(!file.open(QIODevice::ReadOnly|QIODevice::Text)){
        return "Не удалось открыть файл";
    }
    QTextStream in(&file);
    result=in.readAll();
    file.close();
    return result;
}
void fileHandler:: save(QString filePath, QString text)
{
    QFile file(filePath+"/savedText.txt");
    // Открытие файла для записи
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        return;
    }
    // Создание текстового потока для записи в файл
    QTextStream out(&file);
    out<< text;
    file.close(); // Закрытие файла
}
