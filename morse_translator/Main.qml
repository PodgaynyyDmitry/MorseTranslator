import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 6.2
import Qt.labs.platform 1.1
Window {
    width: 400
    height: 300
    minimumHeight: 300
    minimumWidth: 400
    maximumHeight: 300
    maximumWidth: 400
    visible: true
    title: qsTr("Морзе Переводчик")
    Column {
        spacing: 10
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        Row{
            FileDialog{
                id:fileDialog
                title: "Документ"
                nameFilters: ["Текстовые файлы (*.txt)","Все файлы (*)"]
                onAccepted: {var filePath=fileDialog.file.toString()
                    filePath=filePath.replace("file:///","")
                   // filepath.text=filePath
               sourceText.text=handler.readText(filePath)}
                //onRejected: {filepath.text="Выбор отменен"}
            }
            FolderDialog{
                id:save
                title: "Сохраните файл"
                onAccepted: {var filePath=save.folder.toString()
                    filePath=filePath.replace("file:///","")
                    handler.save(filePath,translatedText.text)
                    //filepath.text=filePath
                }
                onRejected: {filepath.text="Выбор отменен"}
            }
            Row{
                Button {
                    text: "Выбрать файл"
                    onClicked:{fileDialog.open()}
                }
                Button {
                    text: "Сохранить как"
                    onClicked:{save.open()}
                }
                spacing:107
                leftPadding:10
            }
        }
        Row {
           // anchors.top: parent
            leftPadding: 10
            spacing: 105
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
                    leftPadding: 10
                    // anchors.right: parent.right
                    // anchors.rightMargin: 10
                    onCurrentIndexChanged:
                        if(targetLanguage.currentIndex==0)
                            sourceLanguage.currentIndex=1
                        else
                            sourceLanguage.currentIndex= 0
                }

        }
        Row{
            width: parent.width
            height: parent.height*0.7
            spacing: 10
            Column{
                // anchors.leftMargin: 10
                width: parent.width/2
                height: parent.height
                    TextArea {
                        id: sourceText
                        placeholderText: "Введите текст"
                        width: parent.width-12
                        height: parent.height
                        anchors.left: parent.left
                        anchors.leftMargin: 10
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
                    placeholderText: "Перевод"
                    width: parent.width-12
                    height: parent.height
                    anchors.right: parent.right
                    anchors.rightMargin: 20
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
