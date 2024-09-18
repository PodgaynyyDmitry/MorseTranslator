#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include<QQmlContext>
#include "trie.h"
#include "hashtable.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    Trie trie;
    trie.insert(".-",'a');
    trie.insert("-...",'b');
    trie.insert("-.-.",'c');
    trie.insert("-..",'d');
    trie.insert(".",'e');
    trie.insert("..-.",'f');
    trie.insert("--.",'g');
    HashTable hashTable;
    hashTable.insert('a',".-");
    hashTable.insert('b',"-...");
    hashTable.insert('c',"-.-.");
    hashTable.insert('d',"-..");
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("trie",&trie);
    engine.rootContext()->setContextProperty("hashTable",&hashTable);
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
