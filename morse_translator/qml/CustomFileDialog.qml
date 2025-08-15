import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 6.2
import QtQuick.Layouts

FileDialog {
    id: id

    property bool isReadMode
    property string id

    function readFile()
    {
        var filePath = id.currentFile.toString()
        if (Qt.platform.os === "windows")
            filePath=filePath.replace("file:///", "")
        else if (Qt.platform.os === "linux" || Qt.platform.os === "osx")
            filePath = filePath.replace("file://", "")
        sourceText.text = fileHandler.readText(filePath)
    }
    
    function saveFile()
    {
        var filePath = id.currentFile.toString()
        if (Qt.platform.os === "windows")
            filePath = filePath.replace("file:///", "")
        else if (Qt.platform.os === "linux" || Qt.platform.os === "osx")
            filePath = filePath.replace("file://", "")
        fileHandler.saveText(filePath,translatedText.text)
    }

    title: isReadMode ? qsTr("Документ") : qsTr("Сохраните файл")
    
    nameFilters: ["Текстовые файлы (*.txt)", "Все файлы (*)"]

    fileMode: isReadMode ? null : FileDialog.SaveFile

    onAccepted: {
        if (isReadMode)
            readFile();
        else
            saveFile();
    }  
}
