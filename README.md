## 系統架構圖

```mermaid
flowchart TD
    subgraph "排程觸發｜每天 02:00"
        SCHED[Python Scheduler<br>form_compare_sql.py]
    end

    GF[Google Form<br>Spreadsheet API]
    SQL[(SQL Server)]

    SCHED -- 取回最新回應 --> GF
    SCHED -- 抓取既有樣本 --> SQL
    SCHED -- 比對後寫回(符合╱不符合) --> GF
    SCHED -- 推播「新增樣本」 --> LINE[LINE Messaging API]

    LINE -- 訊息 --> INTER[訪員]
    LINE -- 訊息 --> RESP[受訪者]
    LINE -- 訊息 --> ADMIN[管理助理]

    classDef process fill:#FDF2E9,stroke:#D35400,stroke-width:1px
    class SCHED process
