#ifndef MORSEENCODER_H
#define MORSEENCODER_H

#include <QObject>
#include "trie.h"
#include "hashtable.h"

class MorseEncoder: public QObject
{
    Q_OBJECT
public:
   explicit MorseEncoder(QObject* parent=nullptr);
    Q_INVOKABLE QString encode(QString text);
    Q_INVOKABLE QString decode(QString text);
private:
    Trie trie;
    HashTable hashTable;
};

#endif // MORSEENCODER_H
