#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>

auto main(int argc, char *argv[]) -> int {
    const QGuiApplication application{argc, argv};
    QGuiApplication::setWindowIcon(QIcon{"res/favicon.ico"});

    const QQmlApplicationEngine engine{"src/main.qml"};

    return QGuiApplication::exec();
}
