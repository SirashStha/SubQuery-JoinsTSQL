BULK INSERT dbo.Job_History --Table Name
FROM 'D:\CSV\job_history_table.csv' -- CSV File Path
WITH
(
        FORMAT='CSV',
        FIRSTROW=1
)
GO
