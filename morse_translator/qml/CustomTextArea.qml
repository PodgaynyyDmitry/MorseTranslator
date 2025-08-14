import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 6.2
import QtQuick.Layouts
import QtQuick.Controls.Material 2.15

Pane {
    id: pane
    property bool isReadOnly: false
    property string text
    property string placeholderText


    Layout.preferredHeight: parent.height
    Layout.preferredWidth: (parent.width / 2) - change.width - 5
    Layout.leftMargin: 10
    
    Material.elevation: 3
    padding: 0
    
    onTextChanged: textArea.text = text

    ColumnLayout {
        height: parent.height
        width: parent.width
        spacing: 8
        
        TextArea {
            id: textArea

            Layout.preferredHeight: parent.height
            Layout.preferredWidth: parent.width
            
            placeholderText: pane.placeholderText
            wrapMode: Text.Wrap

            readOnly: isReadOnly
            onTextChanged: pane.text = textArea.text
        }
    }
}
