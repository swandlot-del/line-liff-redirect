## 系統架構圖

```mermaid
flowchart TD
    subgraph "排程觸發｜每天 02:00"
        PY[read_save_latest_and_notify.py]
    end

    %% 主要資源 --------------------------
    SAVE[save.xlsx]
    SURVEY_OLD["save_survey.xlsx<br/>(舊檔)"]
    SURVEY0["save_survey_0.xlsx<br/>(已推播備份)"]
    SURVEY1["save_survey_1.xlsx<br/>(最新樣本+TeacherQSentDT)"]
    SURVEY_NEW["save_survey.xlsx<br/>(新檔)"]
    SQL[(SQL Server<br/>Samples╱AllProgress)]
    LINE[LINE Messaging API]
    TEACHER["授課老師<br/>(LINE user)"]

    %% 資料流 ----------------------------
    PY -- "讀舊 MsgSent≠空\n→ save_survey_0.xlsx" --> SURVEY_OLD
    PY --> SURVEY0

    PY -- "讀最新回應" --> SAVE
    PY -- "查 TeacherQSentDT" --> SQL
    PY --> SURVEY1

    PY -- "合併去重(舊優先)" --> SURVEY_NEW

    PY -- "推播尚未標記者" --> LINE
    LINE -- "訊息" --> TEACHER

    %% 樣式 ------------------------------
    classDef process fill:#FDF2E9,stroke:#D35400,stroke-width:1px;
    class PY process
