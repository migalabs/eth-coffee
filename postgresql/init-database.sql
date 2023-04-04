CREATE DATABASE ethseer;
\c ethseer;
CREATE TABLE IF NOT EXISTS t_eth2_pubkeys (
	f_val_idx int primary key,
	f_pubkey text,
	f_pool_name text,
	f_pool text);
CREATE TABLE IF NOT EXISTS t_status(
	f_id INT,
	f_status TEXT PRIMARY KEY);
INSERT INTO t_status (f_id, f_status) VALUES (0, 'in queue to activation');
INSERT INTO t_status (f_id, f_status) VALUES (1, 'active');
INSERT INTO t_status (f_id, f_status) VALUES (2, 'exit');
INSERT INTO t_status (f_id, f_status) VALUES (3, 'slashed');