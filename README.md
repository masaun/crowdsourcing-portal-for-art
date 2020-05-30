# Climate Change with Harberger

***
## 【Introduction of Climate Change with Harberger】
- This is a dApp that ...

&nbsp;

## 【User Flow】

&nbsp;

***

## 【Setup】
### Setup wallet by using Metamask
1. Add MetaMask to browser (Chrome or FireFox or Opera or Brave)    
https://metamask.io/  


2. Adjust appropriate newwork below 
```
Kovan Test Network
```

&nbsp;


### Setup backend
1. Deploy contracts to Kovan Test Network
```
(root directory)

$ npm run migrate:ropsten
```

&nbsp;


### Setup frontend
1. Move to `./client`
```
$ cd client
```

2. Add an `.env` file under the directory of `./client`.
```
$ cp .env.example .env
```

3. Execute command below in root directory.
```
$ npm run client
```

4. Access to browser by using link 
```
http://127.0.0.1:3000/data_bounty_platform
```

&nbsp;


***

## 【References】
- [WildCard]：  
  - [Repos]  
    - Hanerger base contract ： https://github.com/wildcards-world/harberger-base-contracts  
    - harberger-ui：https://github.com/wildcards-world/harberger-ui  

  - [Tutorial]
    - Tutorial①：https://dev.to/wildcards/build-your-first-harberger-tax-app-part-1-3gdd
    - Tutorial②：

  - [Article]
    - Patronage As An Asset Class  
      https://blog.simondlr.com/posts/patronage-as-an-asset-class
    - What is Harberger-Tax ?  
      https://medium.com/@simondlr/what-is-harberger-tax-where-does-the-blockchain-fit-in-1329046922c6

  - [VIdeo]
    - [VIDEO] South Africa’s WildCards Project Becomes the First Scalable "Harberger Tax Contract" Live Deployment on Ethereum  
    https://bitcoinke.io/2020/01/the-wildcards-project/
