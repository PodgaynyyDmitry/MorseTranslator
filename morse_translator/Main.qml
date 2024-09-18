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
                //onClicked:
                    //trie.insert("-.",'a')
            }
            Button {
                text: "Сохранить как"
                onClicked:
                translatedText.text=hashTable.find(',')
            }
        }
        // Верхняя панель выбора языков
        Row {
            spacing: 10
            ComboBox {
                id: sourceLanguage
                model: ["Морзе", "Текст"]
                currentIndex: 0
                onCurrentIndexChanged:
                    if(sourceLanguage.currentIndex==0)
                        targetLanguage.currentIndex=1
                    else
                        targetLanguage.currentIndex= 0
            }
            ComboBox {
                id: targetLanguage
                model: ["Морзе", "Текст"]
                currentIndex: 1
                onCurrentIndexChanged:
                    if(targetLanguage.currentIndex==0)
                        sourceLanguage.currentIndex=1
                    else
                        sourceLanguage.currentIndex= 0
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
                    wrapMode: Text.Wrap
                    background:
                        Rectangle {
                            radius: 2
                            border.color: "grey"
                            border.width: 1
                            }
                    onTextChanged: if(sourceText.text.match(/^[\.\-\s]+$/)){
                                               sourceLanguage.currentIndex=0
                                        translatedText.text = morse.decode(sourceText.text)
                                           }
                                    else{
                                        sourceLanguage.currentIndex=1
                                        translatedText.text = morse.encode(sourceText.text)
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
                    wrapMode: Text.Wrap
                    clip: true
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
