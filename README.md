# eth-coffee
Ethereum network's monitor-er

# Requirements

- Synced beacon node in the desired network
- Docker Engine and Docker Compose installed

Please also copy the .env.sample into .env, and fill the necessary for your case.

# Services

## Database
Here we will allocate all information from the State Analyzer tool.
The tool will create the following tables:<br>
- t_epoch_metrics_summary (data about each epoch)<br>
- t_validator_rewards_summary (data about each epoch and validator, only when metric is active)<br>
- t_block_metrics (data about each block)<br>
- t_eth2_pubkeys (here you can define you pubkeys and pools)
- t_proposer_duties<br>
- t_status (link of status id to string)<br>

Please keep in mind that validator data is the most disk consuming data.
14k epochs has taken 1.5TB of disk in the past.

## Analyzer

This service will either fill state data of blocks data.
There are two services, each of them for each of the data.
Please tweak the arguments using the [original repository](https://github.com/cortze/eth-cl-state-analyzer)

## Ethseer Website

There are two services involved in this process.
Ethseer Client will serve the frontend static files.
Ethseer Server opens an API that queries the database, and serves data to the frontend.

# Env file

The first step to prepare for the execution is to copy the `.env.sample` into a `.env` file.
For a minimal execution you need to edit the following variables:

Please write the IP and port where you archival beacon node is placed
<pre>
ANALYZER_BN_ENDPOINT="http://localhost:5052"
</pre>
Please write the IP and port where you execution node is placed (should be the same IP as the beacon node after The Merge)
<pre>
ANALYZER_EL_ENDPOINT="http://localhost:8545"
</pre>

Please write the public IP of the machine where the website will be accesible. This is the public IP where you are deploying this repository.
<pre>
NEXT_PUBLIC_URL_API="http://__publicIP__:5086/v1"
</pre>

For a more custom execution you can edit the database details, in case you have your own database server or want different credentials.

# Execution

1. First of all inititate the database. This will create the database and some tables.<br>
`docker-compose up -d db`
2. After this, please start running the analyzer service, either one of them or both, as needed. The tool will create the necessary tables to insert all  the data.<br>
`docker-compose up analyzer-blocks`<br>
(You can kill it Ctrl+C as soon as it connects to the database)<br>
3. After this, you may run the "triggers.sh" script, under the postgresql folder. This script will create the triggers so the website can server real time data.<br>
`./postgresql/triggers.sh`
4. Run Etheseer client and server. The image needs to rebuild to apply env variables, so this might take some minutes.<br>
`docker-compose up -d ethseer-server ethseer-client`
The ethseer images need to do some startup processes, so please wait a couple of minutes.
You can also track the logs with <br>
`docker-compose logs -f ethseer-client ethseer-server`<br>
Both services should be ready when you hit<br>
Ethseer-server:<br><pre> Database connected</pre>
Ethseer-client:<br> <pre> ready - started server on 0.0.0.0:3000, url: http://localhost:3000
ethseer-client-container | info  - Loaded env from /app/.env</pre>

5. After both client and server are running, you may run the nginx service. <br>
`docker-compose up -d nginx`

Please keep in mind that the only variable you need to fill beforehand is the beacon node, the rest of variables can be the default ones. If you wish, you can modify these as well to adjust to your personal case.

