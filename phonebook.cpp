#include "phonebook.h"
#include <QHash>

Phonebook::Phonebook(QObject* parent)
    : QAbstractListModel(parent)
{
}

int Phonebook::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_contact.size();
}

QVariant Phonebook::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_contact.size()) {
        return QVariant();
    }

    const Contact& contact = m_contact.at(index.row());

    if (role == Qt::DisplayRole) {
        return contact.name + " - " + contact.number;
    } else if (role == Qt::UserRole + 1) {
        return contact.name;
    } else if (role == Qt::UserRole + 2) {
        return contact.number;
    }

    return QVariant();
}

QHash<int, QByteArray> Phonebook::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractItemModel::roleNames();
    roles[Qt::UserRole + 1] = "name";
    roles[Qt::UserRole + 2] = "phone";
    return roles;
}

void Phonebook::addContact(const QString& name, const QString& number)
{
    beginInsertRows(QModelIndex(), rowCount(QModelIndex()), rowCount(QModelIndex()));
    Contact contact;
    contact.name = name;
    contact.number = number;
    m_contact.append(contact);
    endInsertRows();
}

void Phonebook::removeContact(int index)
{
    if (index < 0 || index >= m_contact.size()) {
        return;
    }

    beginRemoveRows(QModelIndex(), index, index);
    m_contact.removeAt(index);
    endRemoveRows();
}
