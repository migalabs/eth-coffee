
DROP TRIGGER IF EXISTS trigger_delete_old_validator_data ON t_epoch_metrics_summary;
DROP function IF EXISTS validator_data_window;

CREATE FUNCTION validator_data_window() RETURNS TRIGGER LANGUAGE plpgsql AS $$
	DECLARE 
	row RECORD; 
BEGIN
	row = NEW;
	DELETE FROM t_validator_rewards_summary WHERE f_epoch <= (row.f_epoch + 1 - 5);
	RETURN NULL;
END;
$$;

CREATE TRIGGER trigger_delete_old_validator_data
  AFTER INSERT 
  ON t_epoch_metrics_summary 
  FOR EACH ROW 
  EXECUTE PROCEDURE validator_data_window(); 