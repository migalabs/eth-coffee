# Ethereum Blockhain Explorer Setup
This repository allows anyone to deploy an Ethereum Blockchain explorer in minutes!

# Requirements

- Synced beacon node in the desired network
- Docker Engine and Docker Compose installed

Please also copy the .env.sample into .env, and fill the necessary for your case.

# Services

## Database
Here we will allocate all information from the GotEth tool.
The tool will create the following tables:<br>
- t_epoch_metrics_summary (data about each epoch)<br>
- t_validator_rewards_summary (data about each epoch and validator, only when metric is active)<br>
- t_block_metrics (data about each block)<br>
- t_eth2_pubkeys (here you can define you pubkeys and pools)
- t_proposer_duties (proposer duties at each epoch)<br>
- t_status (link of status id to string)<br>
- t_validator_last_status (data about validators in the last epoch)<br>

Please keep in mind that validator data is the most disk consuming data.
14k epochs has taken 1.5TB of disk in the past.

## GotEth

This service will either fill state data or blocks data.
Please tweak the arguments using the [original repository](https://github.com/migalabs/goteth)

## Ethseer Website

There are two services involved in this process.
Ethseer Client will serve the frontend static files.
Ethseer Server opens an API that queries the database, and serves data to the frontend.
Please refer [here](https://github.com/migalabs/eth-seer) for more information

# Execution

Please copy the `.env.sample` file into `.env`.<br>
You may edit the `NETWORKS` variable with the appropiate network name.<br>
Then:<br>
`docker-compose up -d`<br>
All systems should boot and start working as normal<br>
Navigate to: `http://yourPublicIP:3010`<br>
You might not see anything here yet until goteth starts filling data (you may have to wait for 3 epochs).

## Desired logs

### GotEth

<pre>
goteth_1  | time="2023-10-17T11:45:49Z" level=info msg="New event: slot 7559927, epoch 236247. 9 pending slots for new epoch" module=Events routine=head-event
goteth_1  | time="2023-10-17T11:45:49Z" level=info msg="block at slot 7559927 downloaded in 0.153967 seconds" module=api-cli
goteth_1  | time="2023-10-17T11:45:49Z" level=info msg="summary for analyzer" last_processed_epoch=236245 last_processed_slot=7559926
goteth_1  | time="2023-10-17T11:46:01Z" level=info msg="New event: slot 7559928, epoch 236247. 8 pending slots for new epoch" module=Events routine=head-event
goteth_1  | time="2023-10-17T11:46:01Z" level=info msg="block at slot 7559928 downloaded in 0.190399 seconds" module=api-cli
goteth_1  | time="2023-10-17T11:46:04Z" level=info msg="summary for analyzer" last_processed_epoch=236245 last_processed_slot=7559928
</pre>

### Ethseer
Both services should be ready when you hit<br>
Ethseer-server:<br><pre> Database connected</pre>
Ethseer-client:<br> <pre> ready - started server on 0.0.0.0:3000, url: http://localhost:3000
ethseer-client-container | info  - Loaded env from /app/.env</pre>

