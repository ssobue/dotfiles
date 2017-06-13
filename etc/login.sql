-- show date
set time on
-- show timer
set timing on
-- show NULL
set null 'NULL'

-- no auto commit
set autocommit off
-- show selected colnm and plan
set autotrace on
-- trim space
set trimspool on
-- show selected line
set feedback on
-- cloumn sepalater
set colsep ' '

set sqlprompt "&_user.@&_connect_identifier> "

ALTER SESSION SET NLS_DATE_FORMAT='YYYYMMDD HH24:MI:SS';

SET LINE 500
SET PAGES 1000
