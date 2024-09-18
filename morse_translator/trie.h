#ifndef TRIE_H
#define TRIE_H

#include <QObject>
struct TrieNode{//узлы дерева
    TrieNode* leftChild;
    TrieNode* rightChild;
    QChar letter;
   //Q_INVOKABLE TrieNode(){this->letter='1';}
};

class Trie: public QObject
{
    Q_OBJECT
public:
   explicit Trie(QObject* parent=nullptr);
   Q_INVOKABLE void insert(QString code, QChar letter);
   Q_INVOKABLE QChar search(QString code);
private:
      TrieNode* root;
};

#endif // TRIE_H
