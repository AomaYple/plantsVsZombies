#pragma once

#include <QJsonArray>

class Archive : public QObject {
    Q_OBJECT
public:
    explicit Archive(QObject *parent = nullptr);

    ~Archive() override;

    Q_INVOKABLE [[nodiscard]] QJsonArray load() const;

    Q_INVOKABLE void save(QJsonArray newArchive);

private:
    QJsonArray archive;
};
