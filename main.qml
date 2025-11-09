import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import phonemodel 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 380
    height: 650
    title: "PhoneBook"
    color: "lightgray"

    Phonebook { id: phonebook }
//TODO: header
    Rectangle {
        width: parent.width
        height: 60
        color: "white"
        anchors.top: parent.top
        border.color: "lightgray"

        Text {
            anchors.centerIn: parent
            text: "Contacts"
            font.pixelSize: 22
            font.bold: true
            color: "black"
        }
    }

    ListView {
        id: listView
        anchors.top: parent.top
        anchors.topMargin: 60
        anchors.bottom: addButton.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 12
        spacing: 6
        clip: true
        model: phonebook

        delegate: Rectangle {
            width: listView.width
            height: 75
            radius: 10
            color: "white"

            RowLayout {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 12

                Rectangle {
                    width: 44; height: 44; radius: 22
                    color: "deepskyblue"
                    Layout.alignment: Qt.AlignVCenter

                    Text {
                        anchors.centerIn: parent
                        text: model.name.charAt(0).toUpper()
                        font.pixelSize: 20
                        color: "white"
                        font.bold: true
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Text {
                        text: name
                        font.pixelSize: 19
                        color: "black"
                        elide: Text.ElideRight
                    }
                    Text {
                        text: model.phone
                        font.pixelSize: 17
                        color: "gray"
                        elide: Text.ElideRight
                    }
                }

                Item {
                    Layout.fillWidth: true
                }

                Button {
                    text: "Delete"//alighncenter
                    flat: true
                    background: Rectangle { color: "red"; radius: 8 }
                    contentItem: Text { text: "Delete"; anchors.centerIn: parent; color: "white"; font.pixelSize: 14 }
                    Layout.preferredWidth: 70
                    Layout.preferredHeight: 34
                    Layout.alignment: Qt.AlignVCenter
                    onClicked: phonebook.removeContact(model.index)
                }
            }

            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width - 24
                height: 1
                color: "blue"
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    Rectangle {
        id: addButton
        width: 60
        height: 60
        radius: 30
        color: "blue"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        z: 10

        Text {
            text: "+"//center
            anchors.centerIn: parent
            font.pixelSize: 36
            font.bold: true
            color: "white"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: addSheet.open()
            onPressed: addButton.scale = 0.9
            onReleased: addButton.scale = 1.0
        }
    }

    Rectangle {
        id: addSheet
        width: parent.width - 40
        height: 280
        color: "white"
        radius: 16
        anchors.horizontalCenter: parent.horizontalCenter
        y: visible ? parent.height - height - 20 : parent.height + 20
        visible: false
        z: 11
        Behavior on y { NumberAnimation { duration: 250; easing.type: Easing.InOutQuad } }

        Rectangle {
            width: 40; height: 5; radius: 3
            color: "lightgray"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 8
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 14

            Text { text: "Add New Contact"; font.pixelSize: 18; font.bold: true; color: "black"; Layout.alignment: Qt.AlignHCenter }

            TextField { id: nameField ;clip: true; placeholderText: "Full Name"; Layout.fillWidth: true; font.pixelSize: 18 }
            TextField { id: phoneField;clip: true; placeholderText: "Phone Number"; Layout.fillWidth: true; inputMethodHints: Qt.ImhDigitsOnly; font.pixelSize: 18 }

            RoundButton {
                text: "Add Contact"
                Layout.fillWidth: true
                clip: true;
                Layout.preferredHeight: 44
                radius: 20
                background: Rectangle { color: "blue"; radius: parent.radius}
                contentItem: Text { text: "Add Contact"; anchors.centerIn: parent; color: "white"; font.pixelSize: 16; font.bold: true }
                onClicked: {
                    if(nameField.text !== "" && phoneField.text !== "") {
                        phonebook.addContact(nameField.text, phoneField.text)
                        nameField.text = ""
                        phoneField.text = ""
                        addSheet.close()
                    }
                }

            }
        }
//todo add photo and icon
        function open() { visible = true }
        function close() { visible = false }
    }


}
