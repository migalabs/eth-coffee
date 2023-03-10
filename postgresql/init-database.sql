CREATE DATABASE ethseer;
\c ethseer;
CREATE TABLE IF NOT EXISTS t_eth2_pubkeys (
	f_val_idx int primary key,
	f_pubkey text,
	f_pool_name text,
	f_pool text);
