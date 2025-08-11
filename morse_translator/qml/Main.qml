import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 6.2
import QtQuick.Layouts
import QtQuick.Controls.Material 2.15

Window {
    width: 400
    height: 300

    minimumWidth: saveButton.width + fileButton.width + 30
    minimumHeight: buttonsRow.height * 3

    Material.theme: Material.Light
    Material.primary: Material.Blue
    Material.accent: Material.LightBlue
    Material.background: "white"

    visible: true
    title: qsTr("Кодировщик азбуки морзе")

    Column {
        width: parent.width
        height: parent.height

        anchors.centerIn: parent

        spacing: 10

        RowLayout {
            width: parent.width

            ToolBar {
                Layout.preferredWidth: parent.width
                Material.elevation: 2
                RowLayout {
                    id: buttonsRow
                    anchors.fill: parent
                    spacing: 8

                    ToolButton {
                        id: fileButton
                        //Layout.alignment: Qt.AlignLeft
                        Layout.alignment: Qt.AlignCenter
                        text: qsTr("Выбрать файл")
                        onClicked: fileDialog.open()
                    }
                    ToolButton {
                        id: saveButton
                        Layout.alignment: Qt.AlignCenter
                        text: qsTr("Сохранить как")
                        onClicked: save.open()
                    }
                    // ToolButton {
                    //     id: closeButton
                    //     Layout.alignment: Qt.AlignRight
                    //     text: qsTr("Выйти")
                    //     //onClicked: window.close()
                    // }
                }
            }
        }

        RowLayout {
            width: parent.width
            height: parent.height - (2 * buttonsRow.height)

            spacing: 10

            TextArea {
                id: sourceText

                Layout.preferredHeight: parent.height
                Layout.preferredWidth: (parent.width / 2) - change.width - 5
                Layout.leftMargin: 10

                placeholderText: "Введите текст"
                wrapMode: Text.Wrap

                onTextChanged:
                    if (sourceText.text.match(/^[\.\-\s]+$/))
                        translatedText.text = morseEncoder.decode(sourceText.text)
                    else
                        translatedText.text = morseEncoder.encode(sourceText.text)
            }

            RoundButton {
                id: change
                text: "↔"        // аналог иконки swap_horiz
                Accessible.name: qsTr("Поменять местами")
                Material.accent: "#1E88E5"
                onClicked: sourceText.text = translatedText.text
            }

            TextArea {
                id: translatedText

                Layout.preferredHeight: parent.height
                Layout.preferredWidth: (parent.width / 2) - change.width - 5
                Layout.rightMargin: 10

                placeholderText: "Перевод"
                wrapMode: Text.Wrap

                clip: true
                readOnly: true
            }
        }
    }

    CustomFileDialog {
        id: fileDialog
        isReadMode: true
    }

    CustomFileDialog {
        id: save
        isReadMode: false
    }
}
