#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include<QQmlContext>
#include "trie.h"
#include "hashtable.h"
#include "morseencoder.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    // QString codes[]={".-","-..","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--",
    //                    "-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--",
    //                    "--..",".-.-.-","--..--","..--..","-.-.-.","-.-.--"};
    // QChar letters[]={'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','.',',',
    //                 '?',';','!'};
    // Trie trie;
    // HashTable hashTable;
    // for (int i = 0; i < sizeof(codes)/sizeof(codes[0]); ++i) {
    //     trie.insert(codes[i],letters[i]);
    //     hashTable.insert(letters[i],codes[i]);
    // }
    MorseEncoder morse;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("morse",&morse);
    // engine.rootContext()->setContextProperty("hashTable",&hashTable);
    const QUrl url(QStringLiteral("qrc:/morse_translator/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);
    return app.exec();

}
