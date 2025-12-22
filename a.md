flowchart TD
    S0([啟動腳本]) --> C1{{save_survey.xlsx\n是否存在?}}

    C1 -- "否" --> R1[讀取 save.xlsx\n取 create_time 最新一筆]
    C1 -- "是" --> B1[讀取 save_survey.xlsx\n篩 MsgSent≠空\n存 save_survey_0.xlsx]
    B1 --> R1

    R1 --> Q1[連 SQL Server\n撈 TeacherQSentDT]
    Q1 --> F1[與最新樣本合併\n→ save_survey_1.xlsx]

    F1 --> M1[concat save_survey_0 + save_survey_1\nSampleID 去重（舊優先）]

    M1 --> L1{{MsgSent 空白且\nTeacherQSentDT 有值?}}

    L1 -- "否" --> W1[寫回 save_survey.xlsx]
    L1 -- "是" --> V1[驗證 applyer_line_id\n(ok_uid)]

    V1 -- "無效 UID" --> I1[註記 INVALID_UID]
    V1 -- "合法 UID" --> P1[push_line 發送訊息]

    P1 -- "成功" --> S1[MsgSent = 時戳]
    P1 -- "失敗" --> F2[MsgSent = FAIL:code]

    I1 --> N1[處理下一筆]
    S1 --> N1
    F2 --> N1
    N1 --> L1

    W1 --> E0([結束])
