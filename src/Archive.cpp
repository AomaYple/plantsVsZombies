#include "Archive.hpp"

#include <QCoreApplication>
#include <QDir>
#include <QJsonDocument>

Archive::Archive(QObject *parent) : QObject{parent} {
    const QString archivePath{QCoreApplication::applicationDirPath() + "/archive"};

    const QDir directory{archivePath};
    if (!directory.exists()) { directory.mkpath("."); }

    QFile file{archivePath + "/archive.json"};
    if (file.exists()) {
        file.open(QIODevice::ReadOnly);
        this->archive = QJsonDocument::fromJson(file.readAll()).array();
    }
}

Archive::~Archive() {
    QFile file{QCoreApplication::applicationDirPath() + "/archive/archive.json"};
    file.open(QIODevice::WriteOnly | QIODevice::Truncate);
    file.write(QJsonDocument{this->archive}.toJson());
}

auto Archive::load() const -> QJsonArray { return this->archive; }

auto Archive::save(QJsonArray newArchive) -> void { this->archive = newArchive; }
