
[![twitter](https://img.shields.io/twitter/follow/safecoins?style=social)](https://twitter.com/safecoins)

---
![Safecoin Logo](https://raw.githubusercontent.com/Fair-Exchange/safecoinwiki/master/Logos/SafeCoin/SafeCoin-Logo-with-text.png "Safecoin Logo")


## Safecoin

This is the official Safecoin sourcecode repository based on https://github.com/Fair-Exchange/safecoin. 

## Development Resources

- Safecoin Website: [https://safecoin.org](https://safecoin.org/)
- Safecoin Blockexplorer: [https://explorer.safecoin.org](https://explorer.safecoin.org/)
- Safecoin Discord: [https://discord.gg/rKK7huf](https://discord.gg/rKK7huf)
- Forum: [https://bitcointalk.org/index.php?topic=2838370.0](https://bitcointalk.org/index.php?topic=2838370.0/)
- Mail: [safe@safecoin.org](mailto:safe@safecoin.org)
- Blog: [https://safecoin.org/news](https://safecoin.org/news/)
- Whitepaper: [Safecoin Whitepaper](https://safecoin.org/whitepaper)

## List of Safecoin Platform Technologies

- SafeNodes - Delayed Proof of Work (dPoW) - Additional security layer and Safecoins own consensus algorithm.
- zk-SNARKs - Safecoin Platform's privacy technology for shielded transactions
- Tokens/Assets Technology - create "colored coins" on the Safecoin Platform and use them - in progress
- CC - Crypto Conditions to realize "smart contract" logic on top of the Safecoin Platform  - in progress
- Assetchains - Create your own Blockchain that inherits all Safecoin Platform functionalities and blockchain interoperability
- Pegged Assets - Chains that maintain a peg to fiat currencies  (SafeCash in progress)
- Peerchains - Scalability solution where sibling chains form a network of blockchains

## Tech Specification
- Max Supply: 36.2 million SAFE
- Block Time: 60 seconds
- Block Reward: 4 SAFE
- Mining Algorithm: Equihash 192_7

## About this Project
Safecoin is a fork of the Komodo and Zcash projects, although we have incorporated significant changes including TLS 1.3 Encryption from Horizen and Equihash 192_7, in collaboration with BTCZ.  Safecoin was launched as a pure Proof of Work coin, and has never had any ICO or Sale of any kind.   We are an Open Source, Peer to Peer project and we support and contribute to likewise initiatives.
Same Zcash is based on Bitcoin's code, with difference Zcash intends to offer a far higher standard of privacy through a sophisticated zero-knowledge proving scheme that preserves confidentiality of transaction metadata. Technical details are available in our [Protocol Specification](https://github.com/zcash/zips/raw/master/protocol/protocol.pdf).

## Getting started

### Dependencies

```shell
#The following packages are needed:
sudo apt-get install build-essential pkg-config libc6-dev m4 g++-multilib autoconf libtool ncurses-dev unzip git python python-zmq zlib1g-dev wget libcurl4-gnutls-dev bsdmainutils automake curl libsodium-dev
```

### Build Safecoin

This software is based on zcash and considered experimental and is continously undergoing heavy development.

The dev branch is considered the bleeding edge codebase while the master-branch is considered tested (unit tests, runtime tests, functionality). At no point of time do the Safecoin Platform developers take any responsbility for any damage out of the usage of this software. 
Safecoin builds for all operating systems out of the same codebase. Follow the OS specific instructions from below.

#### Linux
```shell
git clone https://github.com/Fair-Exchange/safecoin --branch master --single-branch
cd safecoin
./zcutil/fetch-params.sh
./zcutil/build.sh -j$(expr $(nproc) - 1)
#This can take some time.
```


#### OSX
Ensure you have [brew](https://brew.sh) and Command Line Tools installed.
```shell
# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# Install Xcode, opens a pop-up window to install CLT without installing the entire Xcode package
xcode-select --install 
# Update brew and install dependencies
brew update
brew upgrade
brew tap discoteq/discoteq; brew install flock
brew install autoconf autogen automake
brew update && brew install gcc@8
brew install binutils
brew install protobuf
brew install coreutils
brew install wget
# Clone the Safecoin repo
git clone https://github.com/Fair-Exchange/safecoin --branch master --single-branch
# Change master branch to other branch you wish to compile
cd safecoin
./zcutil/fetch-params.sh
./zcutil/build-mac.sh -j$(expr $(sysctl -n hw.ncpu) - 1)
# This can take some time.
```

#### Windows
Use a debian cross-compilation setup with mingw for windows and run:
```shell
sudo apt-get install build-essential pkg-config libc6-dev m4 g++-multilib autoconf libtool ncurses-dev unzip git python python-zmq zlib1g-dev wget libcurl4-gnutls-dev bsdmainutils automake curl cmake mingw-w64 libsodium-dev libevent-dev
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
rustup target add x86_64-pc-windows-gnu
git clone https://github.com/Fair-Exchange/safecoin --branch master --single-branch
cd safecoin
./zcutil/fetch-params.sh
./zcutil/build-win.sh -j$(expr $(nproc) - 1)
#This can take some time.
```
**safecoin is experimental and a work-in-progress.** Use at your own risk.

To reset the Safecoin blockchain change into the *~/.safecoin* data directory and delete the corresponding files by running `rm -rf blocks chainstate debug.log safecoinstate db.log`

#### Create safecoin.conf

Create a safecoin.conf file:

```
mkdir ~/.safecoin
cd ~/.safecoin
touch safecoin.conf

#Add the following lines to the safecoin.conf file:
rpcuser=yourrpcusername
rpcpassword=yoursecurerpcpassword
rpcbind=127.0.0.1
txindex=1
addnode=dnsseed.ipv6admin.com
addnode=dnsseed.fair.exchange
addnode=explorer.safecoin.org
addnode=45.63.13.60
addnode=176.107.179.32
addnode=node.safc.cc

```
### Create your own Blockchain based on Safecoin

Safecoin allows anyone to create a runtime fork which represents an independent Blockchain. Below are the detailed instructions:
Setup two independent servers with at least 1 server having a static IP and build safecoind on those servers.  

#### On server 1 (with static IP) run:
```shell
./safecoind -ac_name=name_of_your_chain -ac_supply=100000 -bind=ip_of_server_1 &
```

#### On server 2 run:
```shell
./safecoind -ac_name=name_of_your_chain -ac_supply=100000 -addnode=ip_of_server_1 -gen &
```

**Safecoin is based on Zcash which is unfinished and highly experimental.** Use at your own risk.

License
-------
For license information see the file [COPYING](COPYING).

**NOTE TO EXCHANGES:**
https://bitcointalk.org/index.php?topic=1605144.msg17732151#msg17732151
There is a small chance that an outbound transaction will give an error due to mismatched values in wallet calculations. There is a -exchange option that you can run safecoind with, but make sure to have the entire transaction history under the same -exchange mode. Otherwise you will get wallet conflicts.

**To change modes:**

a) backup all privkeys (launch safecoind with `-exportdir=<path>` and `dumpwallet`)
b) start a totally new sync including `wallet.dat`, launch with same `exportdir`
c) stop it before it gets too far and import all the privkeys from a) using `safecoin-cli importwallet filename`
d) resume sync till it gets to chaintip

For example:
```shell
./safecoind -exportdir=/tmp &
./safecoin-cli dumpwallet example
./safecoin-cli stop
mv ~/.safecoin ~/.safecoin.old && mkdir ~/.safecoin && cp ~/.safecoin.old/safecoin.conf ~/.safecoin.old/peers.dat ~/.safecoin
./safecoind -exchange -exportdir=/tmp &
./safecoin-cli importwallet /tmp/example
```
---


Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
