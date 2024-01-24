#include "Archive.hpp"

#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQmlContext>

auto main(int argc, char *argv[]) -> int {
    const QGuiApplication application{argc, argv};
    QGuiApplication::setWindowIcon(QIcon{"resources/images/favicon.ico"});

    QQmlApplicationEngine engine;

    Archive archive;
    engine.rootContext()->setContextProperty("archive", &archive);

    engine.load("src/qml/main.qml");

    return QGuiApplication::exec();
}
