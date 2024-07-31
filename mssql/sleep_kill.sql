/* Запустить скрипт выбрать session_id  добавить kill  и убить все процессы */ 
Select  B.session_id,
    A.transaction_id,
    C.transaction_begin_time,
    DATEDIFF(Second,C.transaction_begin_time,getdate()) TimeTaken_In_Seconds,
    B.HOST_NAME,
    B.program_name,
    B.login_name,b.login_time as UserLoginTime,
    e.*
    from sys.dm_tran_session_transactions A Join sys.dm_exec_sessions B On A.session_id=B.session_id 
    Join sys.dm_tran_active_transactions C On A.transaction_id = C.transaction_id
    CROSS APPLY sys.dm_exec_input_buffer(B.session_id, NULL) AS e
    WHERE DATEDIFF(Second,C.transaction_begin_time,getdate())  > 60 * 2
