## 系統架構圖

```mermaid
flowchart TD
    subgraph "排程觸發｜每天 02:00"
        SCHED[Python Scheduler<br>read_save_latest_and_notify.py]
    end

    %% 主要資源 ----------------------------------------------------------------
    SAVE[save.xlsx]
    SURVEY_OLD[save_survey.xlsx<br>(舊資料)]
    SURVEY_NEW[save_survey.xlsx<br>(更新後)]
    SQL[(SQL Server<br>Samples╱AllProgress)]
    LINE[LINE Messaging API]
    TEACHER[授課老師<br>(LINE user)]

    %% 資料流 ------------------------------------------------------------------
    SCHED -- "讀取最新回應" --> SAVE
    SCHED -- "讀取舊 MsgSent\n→ save_survey_0.xlsx" --> SURVEY_OLD
    SCHED -- "合併比對\n→ save_survey_1.xlsx" --> SAVE
    SCHED -- "查詢 TeacherQSentDT" --> SQL
    SCHED -- "寫回最終結果" --> SURVEY_NEW

    SCHED -- "推播尚未標記者" --> LINE
    LINE -- "訊息" --> TEACHER

    %% 樣式 --------------------------------------------------------------------
    classDef process fill:#FDF2E9,stroke:#D35400,stroke-width:1px
    class SCHED process
