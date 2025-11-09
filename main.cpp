#include <QGuiApplication>
#include "phonebook.h"
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<Phonebook>("phonemodel", 1, 0, "Phonebook");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/new/prefix1/main.qml")));

    return app.exec();
}
