flowchart TD
    %%--------------------- 觸發 -------------------------
    subgraph "排程觸發｜每天 02:00"
        PY[read_save_latest_and_notify.py]
    end

    %%--------------------- 資料來源 / 產物 --------------
    SAVE[save.xlsx]
    SURVEY_OLD["save_survey.xlsx<br/>(舊檔)"]
    SURVEY0["save_survey_0.xlsx<br/>(備份已推播)"]
    SURVEY1["save_survey_1.xlsx<br/>(最新樣本+TeacherQSentDT)"]
    SURVEY_NEW["save_survey.xlsx<br/>(新檔)"]
    SQL[(SQL Server<br/>Samples╱AllProgress)]
    LINE[LINE Messaging API]
    TEACHER["授課老師<br/>(LINE user)"]

    %%--------------------- 流程 -------------------------
    PY -- "讀舊檔並萃取\nMsgSent≠空" --> SURVEY_OLD
    PY -- "寫出已推播列" --> SURVEY0

    PY -- "讀取最新回應" --> SAVE
    PY -- "查詢 TeacherQSentDT" --> SQL
    PY -- "寫出最新樣本" --> SURVEY1

    PY -- "合併 0 + 1\n去重(舊優先)" --> SURVEY_NEW

    PY -- "推播尚未標記者" --> LINE
    LINE -- "訊息" --> TEACHER

    %%--------------------- 樣式 -------------------------
    classDef process fill:#FDF2E9,stroke:#D35400,stroke-width:1px;
    class PY process
