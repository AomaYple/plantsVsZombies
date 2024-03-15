#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQmlContext>

auto main(int argc, char *argv[]) -> int {
    const QGuiApplication application{argc, argv};

    QGuiApplication::setWindowIcon(QIcon{"resources/scenes/favicon.ico"});
    const QQmlApplicationEngine engine{"src/main.qml"};

    return QGuiApplication::exec();
}
