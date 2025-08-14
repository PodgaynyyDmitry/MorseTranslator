import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 6.2
import QtQuick.Layouts
import QtQuick.Controls.Material 2.15

ApplicationWindow {
    id: mainWindows
    width: 400
    height: 300

    minimumWidth:  width//saveButton.width + fileButton.width + 30
    minimumHeight: height//buttonsRow.height * 3

    Material.theme: Material.Light
    Material.primary: Material.Blue
    Material.accent: Material.LightBlue
    Material.background: "white"
    flags: Qt.Window | Qt.FramelessWindowHint

    visible: true
    title: qsTr("Кодировщик азбуки морзе")

    color: "#F6F6FB"

    DragHandler {
        id: dragMove
        target: null
        acceptedDevices: PointerDevice.Mouse
        acceptedButtons: Qt.LeftButton
        grabPermissions: PointerHandler.CanTakeOverFromAnything
        onActiveChanged: if (active) mainWindows.startSystemMove()
    }

    property int grip: 6

    // ЛЕВО
    MouseArea {
        anchors.left: parent.left; anchors.top: parent.top; anchors.bottom: parent.bottom
        width: mainWindows.grip; cursorShape: Qt.SizeHorCursor; hoverEnabled: true
        onPressed: if (mouse.button === Qt.LeftButton) mainWindows.startSystemResize(Qt.LeftEdge)
    }
    // ПРАВО
    MouseArea {
        anchors.right: parent.right; anchors.top: parent.top; anchors.bottom: parent.bottom
        width: mainWindows.grip; cursorShape: Qt.SizeHorCursor; hoverEnabled: true
        onPressed: if (mouse.button === Qt.LeftButton) mainWindows.startSystemResize(Qt.RightEdge)
    }
    // ВЕРХ
    MouseArea {
        anchors.top: parent.top; anchors.left: parent.left; anchors.right: parent.right
        height: mainWindows.grip; cursorShape: Qt.SizeVerCursor; hoverEnabled: true
        onPressed: if (mouse.button === Qt.LeftButton) mainWindows.startSystemResize(Qt.TopEdge)
    }
    // НИЗ
    MouseArea {
        anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.right: parent.right
        height: mainWindows.grip; cursorShape: Qt.SizeVerCursor; hoverEnabled: true
        onPressed: if (mouse.button === Qt.LeftButton) mainWindows.startSystemResize(Qt.BottomEdge)
    }

    Column {
        width: parent.width
        height: parent.height

        anchors.centerIn: parent
        //anchors.topMargin: 6
        spacing: 10

        RowLayout {
            width: parent.width

            ToolBar {
                Layout.preferredWidth: parent.width
                Material.elevation: 2
                background: Rectangle {
                    border.width: 0
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#5AA8FF" } // голубой
                        GradientStop { position: 1.0; color: "#3B82F6" } // сине-голубой
                    }
                }

                RowLayout {
                    id: buttonsRow
                    anchors.fill: parent
                    spacing: 0

                    Item {
                        Layout.leftMargin: 10
                        height: 20
                        width: 20
                        Image {
                            // anchors.centerIn: parent
                            // height: 20
                            // width: 20
                            anchors.fill: parent
                            source: "icons/headerIcon.svg"
                        }
                    }

                    Label {
                        Layout.alignment: Qt.AlignVCenter
                        Layout.leftMargin: 10
                        Layout.fillWidth: true
                        text: qsTr("Кодировщик Морзе")
                        color: "white"
                        font.pixelSize: 12
                        font.weight:700
                        elide: Text.ElideRight
                    }

                    ToolButton {
                        id: fileButton
                        //Layout.alignment: Qt.AlignLeft
                        //Layout.alignment: Qt.AlignCenter

                        text: qsTr("Выбрать файл")
                        font.weight:700
                        onClicked: fileDialog.open()
                    }
                    ToolButton {
                        id: saveButton
                        //Layout.alignment: Qt.AlignCenter
                        text: qsTr("Сохранить")
                        font.weight:700
                        onClicked: save.open()
                    }

                    ToolButton {
                        id: closeButton
                        // Layout.alignment: Qt.AlignRight
                        // Material.background: "#1E88E5"       // голубой фон (или Material.accent)
                        // Material.theme: Material.Light       // чтобы контраст был как у Google
                        //text: qsTr("Выйти")

                        Image {
                            id: name
                            anchors.centerIn: parent
                            height: 20
                            width: 20
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

                placeholderText: "Введите текст"

                onTextChanged:
                    if (sourceText.text.match(/^[\.\-\s]+$/))
                        translatedText.text = morseEncoder.decode(sourceText.text)
                    else
                        translatedText.text = morseEncoder.encode(sourceText.text)
            }

            RoundButton {
                id: change
                //text: "↔"                            // стрелка
                //highlighted: true                    // кнопка — «залитая»
                Material.background: "#1E88E5"       // голубой фон (или Material.accent)
                Material.theme: Material.Light       // чтобы контраст был как у Google
                onClicked: sourceText.text = translatedText.text
                Image {
                    anchors.centerIn: parent
                    height: 10
                    width: 20
                    source: "icons/change.svg"
                }
                // при желании увеличьте стрелку:
                // font.pixelSize: 20
            }

            CustomTextArea {
                id: translatedText
                placeholderText: "Перевод"
                isReadOnly: true
            }
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Подсказка: вводить можно только латинские символы"
            color: "grey"
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
