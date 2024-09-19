#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include<QQmlContext>
#include "morseencoder.h"
#include "filehandler.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    MorseEncoder morse;
    FileHandler handler;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("morse",&morse);
    engine.rootContext()->setContextProperty("handler",&handler);
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
