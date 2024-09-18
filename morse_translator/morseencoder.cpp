#include "morseencoder.h"

MorseEncoder::MorseEncoder(QObject* parent):QObject(parent){
    QString codes[]={".-","-..","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--",
                       "-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--",
                       "--..",".-.-.-","--..--","..--..","-.-.-.","-.-.--"};
    QChar letters[]={'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','.',',',
                       '?',';','!'};
    for (int i = 0; i < sizeof(codes)/sizeof(codes[0]); ++i) {
        trie.insert(codes[i],letters[i]);
        hashTable.insert(letters[i],codes[i]);
    }
}
QString MorseEncoder::encode(QString text){
    QString result="";
    for (QChar letter:text) {
        result+=hashTable.find(letter) + " ";
    }
    return result;
}
QString MorseEncoder:: decode(QString text)
{
    QString result;
    QStringList words=text.split("  ");
    for (int i = 0; i < words.count(); ++i) {
        QStringList letters = words[i].split(' ');
        for (QString letter:letters) {
            result+= trie.search(letter);
        }
        result+=' ';
    }
    return result;
}
