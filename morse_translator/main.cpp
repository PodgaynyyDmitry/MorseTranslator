#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include<QQmlContext>
#include "src/morseencoder.h"
#include "src/filehandler.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    MorseEncoder morseEncoder;
    FileHandler fileHandler;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("morseEncoder",&morseEncoder);
    engine.rootContext()->setContextProperty("fileHandler",&fileHandler);
    const QUrl url(QStringLiteral("qrc:/morse_translator/qml/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);
    return app.exec();
}
