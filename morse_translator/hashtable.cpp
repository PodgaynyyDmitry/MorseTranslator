#include "hashtable.h"

HashTable::HashTable(QObject* parent):QObject(parent) {
    for (int i = 0; i < TABLE_SIZE; ++i) {
         keys[i]=' ';
    }
}
void HashTable:: insert(QChar key, QString value){
    int index=HashFunc(key);
    int uniqueIndex = index;
    while(keys[index]!=' ' && keys[index]!=key){
        index= (index+1)%TABLE_SIZE;
        if(index==uniqueIndex)
            return;
    }
    keys[index]=key;
    values[index]=value;
}
QString HashTable::find(QChar key){
    if(key==' '){
        return " ";
    }
    else{
        int index=HashFunc(key);
        int uniqueIndex = index;
        while(keys[index]!=' '){
            if(keys[index]==key)
                return values[index];
            index= (index+1)%TABLE_SIZE;
            if(index==uniqueIndex)
                break;
        }
        return "#";
    }
}
