codeunit 9204 "BackgroundTask"
{

    TableNo = BackgroundTaskLog;

    trigger OnRun()
    begin
        if Rec.CodeunitID <> 0 then
            RunCodeunit(Rec);

        if Rec.BackgroundTask <> Rec.BackgroundTask::None then
            RunBackgroundTask(Rec);

    end;

    local procedure RunCodeunit(var Rec: Record BackgroundTaskLog)
    begin
        Error('Procedure RunCodeunit not implemented.');
    end;

    local procedure RunBackgroundTask(var Rec: Record BackgroundTaskLog)
    var
        IBackgroundTask: Interface IBackgroundTask;
    begin
        IBackgroundTask := Rec.BackgroundTask;
        IBackgroundTask.Execute(GetBackgroundTaskParams(Rec));
    end;

    local procedure GetBackgroundTaskParams(var Rec: Record BackgroundTaskLog): Dictionary of [Text, Text]
    var
        JsonHelper: Codeunit JsonHelper;
        InStr: InStream;
        ParamsJson: JsonObject;
        TempText: Text;
    begin
        Rec.Params.CreateInStream(InStr);
        InStr.Read(TempText);
        ParamsJson.ReadFrom(TempText);
        exit(JsonHelper.JsonObjectToDictionary(ParamsJson));
    end;
}