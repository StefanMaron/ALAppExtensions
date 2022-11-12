codeunit 9206 "JsonHelper"
{
    procedure DictionaryToJsonObject(Dict: Dictionary of [Text, Text]) ReturnObject: JsonObject
    var
        KeyText: Text;
    begin
        foreach KeyText in Dict.Keys do
            ReturnObject.Add(KeyText, Dict.Get(KeyText));
    end;

    procedure JsonObjectToDictionary(JObject: JsonObject) Dict: Dictionary of [Text, Text]
    var
        ValueTextJToken: JsonToken;
        KeyText: Text;
    begin
        foreach KeyText in JObject.Keys do begin
            JObject.Get(KeyText, ValueTextJToken);
            Dict.Add(KeyText, ValueTextJToken.AsValue().AsText());
        end;
    end;
}