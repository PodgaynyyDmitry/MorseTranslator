#include "morseencoder.h"

MorseEncoder::MorseEncoder(QObject *parent) : QObject(parent)
{
    QList<QString> codes={".-","-..","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--",
                          "-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--",
                          "--..",".-.-.-","--..--","..--..","-.-.-.","-.-.--"};
    QList<QChar> letters={'a','b','c','d','e','f','g','h','i','j','k','l','m',
                          'n','o','p','q','r','s','t','u','v','w','x','y','z','.',',',
                          '?',';','!'};
    for (int i = 0; i <letters.count(); ++i) {
        encoder.insert(letters[i],codes[i]);
        decoder.insert(codes[i],letters[i]);
    }
}
QString MorseEncoder::encode(QString value)
{
    QString text = value.toLower();
    QString result="";
    QStringList words = text.split(" ");
    for (int i=0;i<words.count();++i) {
        if(words[i].replace(" ","").length()!=0 ){
            for (QChar letter:words[i]) {
                if(encoder.contains(letter))
                    result+=encoder.find(letter).value()+' ';
            }
            if(i!=words.count()-1)
                result+=' ';
        }
    }
    return result.remove(result.length()-1,1);
}

QString MorseEncoder:: decode(QString value)
{
    QString text = value.toLower();
    QString result;
    if(value.replace(" ","").length()==0)
        return "";
    QStringList words=text.split("  ");
    for (int i = 0; i < words.count(); ++i) {
            QStringList letters = words[i].split(' ');
        if(words[i].replace(" ","").length()!=0 ){
            for (QString letter:letters) {
                if(decoder.contains(letter))
                    result+=decoder.find(letter).value();
            }
            if(i!=words.count()-1)
                result+=' ';
        }
    }
    return result;
}
