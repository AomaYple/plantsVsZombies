#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQmlContext>

auto main(int argc, char *argv[]) -> int {
    const QGuiApplication application{argc, argv};
    QGuiApplication::setWindowIcon(QIcon{"resources/scenes/favicon.ico"});

    const QQmlApplicationEngine engine{"src/scenes/main.qml"};

    return QGuiApplication::exec();
}
