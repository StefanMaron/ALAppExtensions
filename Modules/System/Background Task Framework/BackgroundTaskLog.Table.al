table 9203 "BackgroundTaskLog"
{

    fields
    {
        field(1; EntryNo; Integer)
        {
            AutoIncrement = true;
        }
        field(2; CodeunitID; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; ParentSession; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; UserId; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Params; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(6; BackgroundTask; Enum BackgroundTask)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; EntryNo)
        {
            Clustered = true;
        }
    }
}