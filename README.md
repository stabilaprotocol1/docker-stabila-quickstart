Stabila Quickstart (Docker image)

The purpose of it is to set up a complete private network for Stabila development.

The image exposes:

    FullNode
    SolidityNode
    EventServer

Usage

Pull the image using docker:

docker pull stabilatools/quickstart

Run the container:

docker run -it \
  -p 9090:9090 \
  --rm \
  --name stabila \
  stabilatools/quickstart

Notice the --rm option automatically removes the container after it exits. This is very important because the container cannot be restarted, it MUST be run from scratch to correctly configure the environment.

Verify the image is running correctly:

docker exec -it stabila ps aux

You should see something like this:

USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  20044  1900 pts/0    Ss+  01:42   0:00 bash ./quickstart v2.0.0
root        13  0.2  0.0  50148  1740 pts/0    Sl+  01:42   0:00 redis-server *:6379
root        15  0.0  0.0  20044    40 pts/0    S+   01:42   0:00 bash ./quickstart v2.0.0
root        16 11.5 19.2 5277964 393692 pts/0  Sl+  01:42   0:31 java -jar FullNode.jar -c fullnode.conf --witness
root        43  0.1  1.8 930932 37456 ?        Ssl  01:42   0:00 PM2 v3.3.1: God Daemon (/root/.pm2)
root        54  0.2  2.6 939316 54880 ?        Ssl  01:42   0:00 /stabila/evenstabila/evenstabila
root        67  0.5  3.1 941540 64212 pts/0    Sl+  01:42   0:01 node /stabila/app
root        72  412 32.0 5208448 655136 pts/0  Sl+  01:42  18:49 java -jar BlockParser.jar --Node-list 127.0.0.1 --intial-block 1 -end -1 --event-server http://127.0.0.1:8060 --secret-key TNSpckEZhGfZ4ryidHG2fYWMARLpZ6U139
root       261  0.0  0.1  20176  3748 pts/1    Ss   01:46   0:00 bash
root       289  0.0  0.1  36068  3168 pts/1    R+   01:47   0:00 ps aux

If redis-server, nodes, or the event server are not running, exit and run the container again.

To see the logs of the full node you can execute

docker exec -it stabila tail -f /stabila/FullNode/logs/stabila.log

StabilaBox 2.1+ configuration

Configure your stabilabox.js file as:

module.exports = {
  networks: {
    development: {
      privateKey: 'da146374a75310b9666e834ee4ad0866d6f4035967bfc76217c5a495fff9f0d0',
      fullHost: "http://127.0.0.1:9090",
      network_id: "9"
    }
  }
};

StabilaWeb configuration

Instantiate stabilaWeb as in the following example:

const StabilaWeb = require('stabilaweb')

const stabilaWeb = new StabilaWeb(
    "http://127.0.0.1:9090",
    "http://127.0.0.1:9090",
    "http://127.0.0.1:9090",
    'da146374a75310b9666e834ee4ad0866d6f4035967bfc76217c5a495fff9f0d0',
)

Testing

Stabila Quickstart sets up accounts to be used for tests with StabilaBox 2.1+ (10 accounts by default). Once the transactions are mined, the final output is printed out:

Available Accounts
==================

(0) SUSdSJMerVr1XezP7bjhSANWYkZkyJeQEs (100000 STB)
(1) SSVezpwJh55m662o5MsyF85GPVTBD755WR (100000 STB)
(2) SQZUUJBNauJmKByVRqQQqfVMhhiWfnozWS (100000 STB)
(3) SVF9CquDqVZhkKbhxm5D6zvVf8QBjaNQhY (100000 STB)
(4) SdVbw9J9cFCi9rUmq4DAFNNifBgqiHnXeo (100000 STB)
(5) SWPh17qJfMFH9CsoNTTQEYmdot38JoHdea (100000 STB)
(6) SiJJucBbd1ksaY5biXi4V2GqdU1JipF5GL (100000 STB)
(7) SWsEHK9hNWDMVieKQQ76LYMUEhnNWYQdrw (100000 STB)
(8) SbN3vwsPjpdoiQxVJBua7gTez39Vmsjhzp (100000 STB)
(9) SX1seBQJjvuoJKCzSPGbxRrcdTZ319ShTT (100000 STB)

Private Keys
==================

(0) 50295b1e309646f327b0e52b3e5482e43f65bf2428c85850455d2b4d0f55ea61
(1) bc9777881f405f421d1d22aaea1083cbe77796420061ab0de148aa3074350a8d
(2) 8bcbefbca00ae104ae39266b786a4f579a7595ac63347a023011fd15452d8399
(3) f7ef479ab123e5b5921694bdce296e2d6f0b83b2165f585eca6158b0dd3d9381
(4) 0e01bb2efea21a914836961dfe5d9c9079d85acdd32c68a5cdd40aab0ab6e40b
(5) 84deb2620062b354314430e52825ba4af59b114ba2c1691263d288109e8ad2c8
(6) 6a19abf177d614908e67bb326635ba6f80df03095fce6a803dd0f42a4fbe6718
(7) 41b4d8ec63ba6f9243a368ddbac3368c4e69d5298a9bcdb6e0fdb1c33a58b09f
(8) 65b0799156e773d8d44d32769770d401d4c80f081ca3ee98fe137d46b16f9c17
(9) 385dc529f153adfdf2bbc46e8098f0d7a5d96105dcbe8995a8c8271d763c06da

HD Wallet
==================
Mnemonic:      treat nation math panel calm spy much obey moral hazard they sorry
Base HD Path:  m/44'/60'/0'/0/{account_index}

Quickstart options:

Use -e flag to pass environmental variables to the docker. Example:

docker run -it \
  -p 9090:9090 \
  --rm \
  --name stabila \
  -e "accounts=20" \
  stabilatools/quickstart

List of options:

    accounts=12 sets the number of generated accounts
    useDefaultPrivateKey=true tells Quickstart to use the default account as accounts[0]
    mnemonic=wrong bit chicken kitchen rat uses a specified mnemonic
    defaultBalance=100000 sets the initial balance for the generated accounts (in the example to 100,000 STB)
    seed=ushwe63hgeWUS sets the seed to be used to generate the mnemonic (if none is passed)
    hdPath=m/44'/60'/0'/0 sets a custom bit39 hdPath
    formatJson=true formats the output
    preapprove=... pre approved proposals (see below for more help)

Pre-approved proposals

To pre-approve, for example, getMultiSignFee and allowMultiSign, you can run the images as:

docker run -it \
  -p 9090:9090 \
  --rm \
  --name stabila \
  -e "preapprove=multiSignFee:1,allowMultiSign:1" \
  stabilatools/quickstart

For a complete list of option proposals check out https://api.stabilagrid.io/wallet/getchainparameters. Note that you remove the "get" part of this chain parameter and lowercase the first character. This allows you to directly edit these parameters.
Available accounts

At any moment, to see the generated accounts, run

curl http://127.0.0.1:9090/admin/accounts

If you prefer to see the addresses in hex format you can run

curl http://127.0.0.1:9090/admin/accounts?format=hex

And if you like to see both formats, you can run

curl http://127.0.0.1:9090/admin/accounts?format=all

More accounts?

If your test requires additional accounts, use the following code to generate new addresses and retrieve them:

async function newTestAccounts(amount) => {
    return await stabilaWeb.fullNode.request('/admin/temporary-accounts-generation?accounts=' + amount);
}

async function getTestAccounts() => {
    const accounts = {
        b58: [],
        hex: [],
        pks: []
    }
    const accountsJson = await stabilaWeb.fullNode.request('/admin/accounts-json');
    accounts.pks = accountsJson.more[accountsJson.more.length - 1].privateKeys
    for (let i = 0; i < accounts.pks.length; i++) {
        let addr = stabilaWeb.address.fromPrivateKey(accounts.pks[i]);
        accounts.b58.push(addr);
        accounts.hex.push(stabilaWeb.address.toHex(addr));
    }
    return accounts;
}

Persistency

If you would like to use the same accounts each time, there are two ways to do that:

    By passing a mnemonic to the docker
    By using accounts.json

Example use of accounts.json:

if [[ ! -d "accounts-data" ]]; then mkdir accounts-data; fi

docker run -it -p 9090:9090 \
  --name stabila \
  -v $PWD/accounts-data:/config \
  stabilatools/quickstart

If accounts-data/accounts.json exists, Stabila Quickstart will use it each time it runs. If you need specific addresses, you can edit accounts.json, put your own private keys in the privateKeys array, and run the container.
Logging

By default, the proxy server returns a verbose log, containing the response of any command. If you prefer just to know what has been called, you can add the option -e "quiet=true". For consistency there is also the option -e "verbose=true". In case both "quiet=true" and "verbose=true" options are passed, the "verbose=true" takes precedence, with quiet being ignored.

verbose mode options:

    -e "showQueryString=true": shows the queryString of any command
    -e "showBody=true": shows the parameter passed to a POST command

Update environment variables

You can update environmental variables, at any time, with curl as follows:

curl http://127.0.0.1:9090/admin/set-env?showBody=true

Interacting with the private network

The easiest way to interact with the private network is by using StabilaWeb from the container:

docker exec -it stabila ./stabilaWeb

It opens a console with a stabilaWeb instance ready to use. Run any command — for example: stabilaWeb.toHex("some") — to verify that it works.
What about RPC?

If you are running Stabila Wallet-cli or any other tool which connects to the private network via RPC, you can just expose the ports . . . and voila!

docker run -it -p 50051:50051 -p 50052:50052 \
  --name stabila \
  stabilatools/quickstart

Known issues

The "SERVER_BUSY" error

Running StabilaBox can put a lot of stress on the local network. If the FullNode is busy, it returns the "SERVER_BUSY" error. If it does, just repeat your command.
Latest version is 2.0.22

To be updated, take a look at https://hub.docker.com/r/stabilatools/quickstart/tags/

You can see which version you currently running executing

docker ps

If you want also to know which version of JavaStabila is used by Stabila Quickstart, run

curl localhost:9090/wallet/getnodeinfo

and look for codeVersion.
Selected recent history

Notice that deprecated version will stay here in the history but will be removed from the Docker hub.

2.1.1

    Upgrade Evenstabila to ed9c7a7, BlockParser to 75b4fec.

2.1.0

    Upgrade FullNode to 3.6.6.

2.0.22

    Fix hdPath.

2.0.21

    Extending the http body size.

2.0.20

    Update StabilaWeb to version 2.8.0 supporting Solidity 0.5.9.

2.0.19

    Update StabilaWeb to version 2.7.4.

2.0.18

    Update JavaStabila to version 3.6.5.
    Update StabilaWeb to version 2.7.3.

2.0.17

    Update StabilaWeb to version 2.6.8.

2.0.17

    Update StabilaWeb to version 2.6.4.

2.0.16

    Pre-approve allowSvmConstantinople and others.

2.0.15

    Upgrade Evenstabila.

2.0.14

    Upgrade JavaStabila to version 3.6.
    Upgrade StabilaWeb to version 2.5.6.

2.0.13

    Remove sleep dependency.

2.0.12

    Allow the proxy to accept large JSON files.

2.0.11

    Fix minor bug with unsupported APIs.

2.0.10

    Update evenstabila to version 2.2.8.
    Fix issue with APIs not supported in private networks.

2.0.9

    Update evenstabila to version 2.2.6.

2.0.8

    Update StabilaWeb to 2.3.6.
    Fix naming issue with JavaStabila 3.2 approved proposals.

2.0.7

    Support generic pre-approved options.

2.0.6

    Disable caching in Evenstabila.

2.0.5

    Pre-approve JavaStabila 3.2 proposals.

2.0.4

    Fix bug with fullnode not starting correctly.

2.0.3

    Fix bug with pre-approved proposals.

2.0.2

    Updates to StabilaGrid v2.2.0
    Updates to a new BlockParser using less resources

2.0.1

    Updates to StabilaGrid v2.1.1 (better support of sort by timestamps)

2.0.1

    Updates to StabilaGrid v2.1.1 (better support of sort by timestamps)

2.0.0

    Updates to JavaStabila 3.5.0.1
    Uses StabilaGrid v2
    Supports pre-approved proposals, to be set using env variables (see above)
        getMultiSignFee
        getUpdateAccountPermissionFee
        getTotalUcrTargetLimit

1.2.8

    Supports pre-approved proposals, to be set using env variables (see above)
        allowSameTokenName
        allowDelegateResource
        allowSvmTransferTrc10

1.2.7

    Updates to JavaStabila v3.2.2.
    Supports events emitted by internal transactions.

1.2.6

    Uses JavaStabila v3.2.1.2.
    Adds a script to have info about the current version of Stabila Quickstart and JavaStabila.

1.2.5

    Uses JavaStabila v3.2.1.1.

1.2.4

    Allow to see the version of the current image from docker ps.

1.2.3

    Add CORS to any /admin routes that returns JSON objects.

1.2.2

    Introduce compatibility with JavaStabila 3.2. It requires StabilaBox >= 2.2.1, because JavaStabila 3.2 requires the new parameter origin_ucr_limit.
