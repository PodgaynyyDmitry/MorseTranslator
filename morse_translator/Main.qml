import QtQuick
import QtQuick.Controls 2.15
Window {
    width: 400
    height: 300
    visible: true
    title: qsTr("Переводчик Морзе")
    Column {
       // anchors.centerIn: parent
        spacing: 10
        width: parent.width
        height: parent.height
        Row{
            Button {
                text: "Документ"
            }
            Button {
                text: "Сохранить как"
            }
        }
        // Верхняя панель выбора языков
        Row {
            spacing: 10
            ComboBox {
                id: sourceLanguage
                model: ["Морзе", "Текст"]
                currentIndex: 0
            }
            ComboBox {
                id: targetLanguage
                model: ["Морзе", "Текст"]
                currentIndex: 1
            }
        }

    // Поле ввода исходного текста
        Row{
            width: parent.width * 0.8
            height: parent.height*0.3
            spacing: 15
            Column{
                width: parent.width/2
                height: parent.height
                spacing: 10
                TextArea {
                    id: sourceText
                    placeholderText: "Enter text here"
                    width: parent.width
                    height: parent.height
                    background:
                        Rectangle {
                            radius: 2
                            border.color: "grey"
                            border.width: 1
                            }
                }
            }
            Column{
                width: parent.width/2
                height: parent.height
                spacing: 10
                TextArea {
                    id: translatedText
                    placeholderText: "Translation will appear here"
                    width: parent.width
                    height: parent.height
                    readOnly: true
                    background:
                        Rectangle {
                            radius: 2
                            border.color: "grey"
                            border.width: 1
                            }
                }
            }


        }
    }
}
