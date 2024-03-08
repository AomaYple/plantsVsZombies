#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQmlContext>

auto main(int argc, char *argv[]) -> int {
    const QGuiApplication application{argc, argv};

    const QString rootPath{QGuiApplication::applicationDirPath()};
    QGuiApplication::setWindowIcon(QIcon{rootPath + "/resources/scenes/favicon.ico"});

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("rootPath", rootPath);
    engine.load(rootPath + "/src/main.qml");

    return QGuiApplication::exec();
}
