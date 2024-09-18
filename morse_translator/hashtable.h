#ifndef HASHTABLE_H
#define HASHTABLE_H

#include <QObject>
const int TABLE_SIZE=32;
class HashTable: public QObject
{
    Q_OBJECT
public:
    explicit HashTable(QObject* parent=nullptr);
    Q_INVOKABLE void insert(QChar key, QString value);
    Q_INVOKABLE QString find(QChar key);
private:
    QChar keys[TABLE_SIZE];
    QString values[TABLE_SIZE];
    int HashFunc(QChar key){
        return int(key.toLatin1()) % TABLE_SIZE;
    }
};

#endif // HASHTABLE_H
