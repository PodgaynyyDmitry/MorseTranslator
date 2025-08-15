import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 6.2
import QtQuick.Layouts
import QtQuick.Controls.Material 2.15

ApplicationWindow {
    id: mainWindow

    property int grip: 6

    width: 400
    height: 300

    minimumWidth:  width
    minimumHeight: height

    Material.theme: Material.Light
    Material.primary: Material.Blue
    Material.accent: Material.LightBlue
    Material.background: "white"

    flags: Qt.Window | Qt.FramelessWindowHint

    visible: true

    color: "#F6F6FB"

    DragHandler {
        id: dragMove
        target: null
        acceptedDevices: PointerDevice.Mouse
        acceptedButtons: Qt.LeftButton
        grabPermissions: PointerHandler.CanTakeOverFromAnything
        onActiveChanged: if (active) mainWindow.startSystemMove()
    }

    MouseArea {
        anchors.left: parent.left; anchors.top: parent.top; anchors.bottom: parent.bottom
        width: mainWindow.grip; cursorShape: Qt.SizeHorCursor; hoverEnabled: true
        onPressed: if (mouse.button === Qt.LeftButton) mainWindow.startSystemResize(Qt.LeftEdge)
    }

    MouseArea {
        anchors.right: parent.right; anchors.top: parent.top; anchors.bottom: parent.bottom
        width: mainWindow.grip; cursorShape: Qt.SizeHorCursor; hoverEnabled: true
        onPressed: if (mouse.button === Qt.LeftButton) mainWindow.startSystemResize(Qt.RightEdge)
    }

    MouseArea {
        anchors.top: parent.top; anchors.left: parent.left; anchors.right: parent.right
        height: mainWindow.grip; cursorShape: Qt.SizeVerCursor; hoverEnabled: true
        onPressed: if (mouse.button === Qt.LeftButton) mainWindow.startSystemResize(Qt.TopEdge)
    }

    MouseArea {
        anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.right: parent.right
        height: mainWindow.grip; cursorShape: Qt.SizeVerCursor; hoverEnabled: true
        onPressed: if (mouse.button === Qt.LeftButton) mainWindow.startSystemResize(Qt.BottomEdge)
    }

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

                background: Rectangle {
                    border.width: 0

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#5AA8FF" }
                        GradientStop { position: 1.0; color: "#3B82F6" }
                    }
                }

                RowLayout {
                    id: buttonsRow
                    anchors.fill: parent
                    spacing: 0

                    Item {
                        height: 20
                        width: 20

                        Layout.leftMargin: 10

                        Image {
                            anchors.fill: parent
                            source: "icons/headerIcon.svg"
                        }
                    }

                    Label {
                        Layout.alignment: Qt.AlignVCenter
                        Layout.leftMargin: 10
                        Layout.fillWidth: true

                        text: qsTr("Кодировщик Морзе")

                        color: "#ffffff"
                        elide: Text.ElideRight

                        font {
                            pixelSize: 12
                            weight:700
                        }
                    }

                    ToolButton {
                        id: fileButton

                        text: qsTr("Выбрать файл")
                        font.weight:700

                        onClicked: chooseFile.open()
                    }

                    ToolButton {
                        id: saveButton

                        text: qsTr("Сохранить")
                        font.weight:700

                        onClicked: saveFile.open()
                    }

                    ToolButton {
                        id: closeButton

                        Image {
                            id: name

                            height: 20
                            width: 20

                            anchors.centerIn: parent

                            source: "icons/logout.svg"
                        }

                        onClicked: Qt.quit()
                    }
                }
            }
        }

        RowLayout {
            width: parent.width
            height: parent.height - (2 * buttonsRow.height)

            spacing: 10

            CustomTextArea {
                id: sourceText

                Layout.leftMargin: 15

                placeholderText: qsTr("Введите текст")

                onTextChanged:
                    if (sourceText.text.match(/^[\.\-\s]+$/))
                        translatedText.text = morseEncoder.decode(sourceText.text)
                    else
                        translatedText.text = morseEncoder.encode(sourceText.text)
            }

            RoundButton {
                id: change

                Material.background: "#1E88E5"
                Material.theme: Material.Light

                onClicked: sourceText.text = translatedText.text

                Image {
                    height: 10
                    width: 20

                    anchors.centerIn: parent

                    source: "icons/change.svg"
                }
            }

            CustomTextArea {
                id: translatedText

                Layout.rightMargin: 15

                placeholderText: qsTr("Перевод")
                isReadOnly: true
            }
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Подсказка: вводить можно только латинские символы")
            color: "#808080"
        }
    }

    CustomFileDialog {
        id: chooseFile
        isReadMode: true
    }

    CustomFileDialog {
        id: saveFile
        isReadMode: false
    }
}
