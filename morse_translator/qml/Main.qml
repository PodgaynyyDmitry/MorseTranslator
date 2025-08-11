import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 6.2

Window {
    width: 400
    height: 300

    minimumWidth: saveButton.width + fileButton.width + 30
    minimumHeight: buttonsRow.height * 3

    visible: true
    title: qsTr("Морзе Переводчик")

    Column {
        width: parent.width
        height: parent.height

        anchors.centerIn: parent

        spacing: 10

        Row {
            id: buttonsRow

            FileDialog {
                id: fileDialog

                title: "Документ"

                nameFilters: ["Текстовые файлы (*.txt)", "Все файлы (*)"]

                onAccepted: {
                    var filePath = fileDialog.currentFile.toString()
                    if (Qt.platform.os === "windows")
                        filePath=filePath.replace("file:///", "")
                    else if (Qt.platform.os === "linux" || Qt.platform.os === "osx")
                        filePath = filePath.replace("file://", "")
                    sourceText.text = fileHandler.readText(filePath)
                }
            }

            FileDialog {
                id: save

                title: "Сохраните файл"

                fileMode: FileDialog.SaveFile
                nameFilters: ["Текстовые файлы (*.txt)", "Все файлы (*)"]

                onAccepted: {
                    var filePath = save.currentFile.toString()
                    if (Qt.platform.os === "windows")
                        filePath = filePath.replace("file:///", "")
                    else if (Qt.platform.os === "linux" || Qt.platform.os === "osx")
                        filePath = filePath.replace("file://", "")
                    fileHandler.saveText(filePath,translatedText.text)
                }
            }

            Row {
                anchors.left: parent

                leftPadding: 10
                spacing: 20

                Column {
                    width: fileButton.width
                    height: fileButton.height

                    Button {
                        id: fileButton
                        text: "Выбрать файл"

                        onClicked: fileDialog.open()
                    }
                }

                Column {
                    width: saveButton.width
                    height: saveButton.height

                    Button {
                        id: saveButton
                        text: "Сохранить как"

                        onClicked: save.open()
                    }
                }
            }
        }
        Row {
            width: parent.width
            height: parent.height - (2 * buttonsRow.height)

            spacing: 15

            Column {
                width: (parent.width / 2) - change.width
                height: parent.height

                TextArea {
                    id: sourceText

                    width: parent.width
                    height: parent.height

                    anchors{
                        left: parent.left
                        leftMargin: 10
                    }

                    placeholderText: "Введите текст"
                    wrapMode: Text.Wrap

                    background: Rectangle {
                        radius: 2

                        border{
                            color: "grey"
                            width: 1
                        }
                    }

                    onTextChanged:
                        if (sourceText.text.match(/^[\.\-\s]+$/))
                            translatedText.text = morseEncoder.decode(sourceText.text)
                        else
                            translatedText.text = morseEncoder.encode(sourceText.text)
                }
            }
            Column {
                width: change.width
                height: change.height

                topPadding: sourceText.height / 3

                Button {
                    id: change
                    text: "<->"
                    onClicked: sourceText.text = translatedText.text
                }
            }

            Column {
                width: (parent.width / 2) - change.width
                height: parent.height

                TextArea {
                    id: translatedText

                    width: parent.width
                    height: parent.height

                    anchors{
                        right: parent.right
                        rightMargin: 10
                    }

                    placeholderText: "Перевод"
                    wrapMode: Text.Wrap

                    clip: true
                    readOnly: true

                    background: Rectangle {
                        radius: 2

                        border{
                            color: "grey"
                            width: 1
                        }
                    }
                }
            }
        }
    }
}
