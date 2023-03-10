
CREATE OR REPLACE FUNCTION notify_head_insert() RETURNS TRIGGER AS $$ 
    DECLARE 
    row RECORD; 
    output TEXT; 
    BEGIN 
	row = NEW; 

    -- Forming the Output as notification. You can choose you own notification. 
    output = 'OPERATION = ' || TG_OP || ' and Slot = ' || row.f_slot; 
    -- Calling the pg_notify for my_table_update event with output as payload 
    PERFORM pg_notify('new_head',output); 
    -- Returning null because it is an after trigger. 
    RETURN NULL; 
    END; 
$$ LANGUAGE plpgsql; 
 

CREATE TRIGGER trigger_notify_new_head 
  AFTER INSERT 
  ON t_block_metrics 
  FOR EACH ROW 
  EXECUTE PROCEDURE notify_head_insert(); 
 


CREATE OR REPLACE FUNCTION notify_epoch_insert() RETURNS TRIGGER AS $$ 
	DECLARE 
	row RECORD; 
	output TEXT; 
    BEGIN 
    row = NEW; 

    -- Forming the Output as notification. You can choose you own notification. 
    output = 'OPERATION = ' || TG_OP || ' and Epoch = ' || row.f_epoch; 
    -- Calling the pg_notify for my_table_update event with output as payload 

    PERFORM pg_notify('new_epoch_finalized',output); 

    -- Returning null because it is an after trigger. 
    RETURN NULL; 
    END; 
$$ LANGUAGE plpgsql; 


CREATE TRIGGER trigger_notify_new_head 
  AFTER INSERT 
  ON t_epoch_metrics_summary 
  FOR EACH ROW 
  EXECUTE PROCEDURE notify_epoch_insert(); 