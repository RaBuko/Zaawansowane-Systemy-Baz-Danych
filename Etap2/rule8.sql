
CREATE TABLE users_log (
  logID int GENERATED ALWAYS AS IDENTITY,
  user_name VARCHAR2(30),
  activity VARCHAR2(20),
  event_date TIMESTAMP
);

CREATE OR REPLACE TRIGGER logon_trigger
  AFTER LOGON
  ON DATABASE
BEGIN
  INSERT INTO users_log (user_name, activity, event_date)
  VALUES (USER, 'LOGON', CURRENT_TIMESTAMP);
END;

CREATE OR REPLACE TRIGGER logoff_trigger
  BEFORE LOGOFF
  ON DATABASE
BEGIN
  INSERT INTO users_log (user_name, activity, event_date)
  VALUES (USER, 'LOGOFF', CURRENT_TIMESTAMP);
END;

