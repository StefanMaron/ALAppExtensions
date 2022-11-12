codeunit 9203 "Task"
{
    var
        BackgroundTaskLog: Record BackgroundTaskLog;

    procedure Run(CodeunitID: Integer)
    begin
        if IsRunning() then
            Error('A task is already running in this instance');

        BackgroundTaskLog.Init();
        BackgroundTaskLog.Insert(true);
        BackgroundTaskLog.Validate(CodeunitID, CodeunitID);
        BackgroundTaskLog.Validate(ParentSession, SessionId());
        BackgroundTaskLog.Validate(UserId, UserId());
        BackgroundTaskLog.Modify(true);


        TaskScheduler.CreateTask(Codeunit::BackgroundTask, 0, true, CompanyName, CurrentDateTime(), BackgroundTaskLog.RecordId);
    end;

    procedure Run(CodeunitID: Integer; ICallback: Interface "ICallback"; CallbackParams: Dictionary of [Text, Text])
    begin
        Run(CodeunitID);
        ICallback.Callback(CallbackParams);
    end;

    procedure Run(BackgroundTask: Enum BackgroundTask; BackgroundParams: Dictionary of [Text, Text])
    begin
        if IsRunning() then
            Error('A task is already running in this instance');

        BackgroundTaskLog.Init();
        BackgroundTaskLog.Insert(true);
        BackgroundTaskLog.Validate(BackgroundTask, BackgroundTask);
        BackgroundTaskLog.Validate(ParentSession, SessionId());
        BackgroundTaskLog.Validate(UserId, UserId());
        BackgroundTaskLog.Modify(true);

        SaveBackgroundTaskParams(BackgroundParams);

        TaskScheduler.CreateTask(Codeunit::BackgroundTask, 0, true, CompanyName, CurrentDateTime(), BackgroundTaskLog.RecordId);
    end;

    procedure IsRunning(): Boolean
    begin
        if BackgroundTaskLog.EntryNo = 0 then exit(false);
        // if BackgroundTaskLog.Status <> BackgroundTaskLog.Status::Running then exit(false);

        exit(true);
    end;

    procedure Await()
    begin
        while IsRunning() do
            Sleep(1000);
    end;

    local procedure SaveBackgroundTaskParams(BackgroundParams: Dictionary of [Text, Text])
    var
        JsonHelper: Codeunit JsonHelper;
        OutStr: OutStream;
        TempText: Text;
    begin
        BackgroundTaskLog.Params.CreateOutStream(OutStr);
        JsonHelper.DictionaryToJsonObject(BackgroundParams).WriteTo(TempText);
        OutStr.Write(TempText);
        BackgroundTaskLog.Modify(true);
    end;
}