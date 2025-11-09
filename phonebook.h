#ifndef PHONEBOOK_H
#define PHONEBOOK_H

#include <QAbstractListModel>
#include <QString>
#include <QVector>

struct Contact
{
    QString name;
    QString number;
};

class Phonebook: public QAbstractListModel
{
    Q_OBJECT

public:
    explicit Phonebook(QObject* parent = nullptr);
    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void addContact(const QString& name, const QString& number);
    Q_INVOKABLE void removeContact(int index);
private:

    QVector<Contact> m_contact;
};

#endif // PHONEBOOK_H
