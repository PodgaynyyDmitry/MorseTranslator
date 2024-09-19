#include "trie.h"

Trie::Trie(QObject* parent):QObject(parent) {
    this->root=new TrieNode();
}
void Trie::insert(QString code, QChar letter){
    TrieNode *current = root;
    for(QChar symbol:code){
        if(symbol=='.'){
            if(current->leftChild==nullptr){
                current->leftChild=new TrieNode();
                current=current->leftChild;
            }
            else
                current=current->leftChild;
        }
        if(symbol=='-'){
            if(current->rightChild==nullptr){
                current->rightChild=new TrieNode();
                current=current->rightChild;
            }
            else
                current=current->rightChild;
        }
    }
    current->letter= letter;
}

QChar Trie::search(QString code){
    TrieNode * current=root;
    for(QChar symbol: code){
            if(symbol=='.'){
                if(current->leftChild!=nullptr)
                    current=current->leftChild;
                else
                     return '1';
            }
            if(symbol=='-'){
                 if(current->rightChild!=nullptr)
                    current=current->rightChild;
                 else
                     return '1';
            }
    }
    return current->letter;
  }
