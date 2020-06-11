# Crowdsourcing Portal For Art

***
## 【Introduction of Crowdsourcing Portal For Art】
- This is a dApp that crowdsourcing portal for art for new wildcards.
  - Anyone become wildcard designer and publish art for new wildcards.
  - Only user who deposited can vote for a favorite artwork of new wildcard.
  - Deposited amount from users is pooled and lended into lending-protocol (AAVE). After interests are generated.
  - Generated interests is distributed into Wildcard designer who got the most voting count.
    (Deposited amount will be lend again for next voting round)

&nbsp;

## 【User Flow】
- ① Wildcard designer publish art for new wildcards
- ② User deposit DAI.
- ③ User vote for a favorite artwork of new wildcard.
    （Only user who deposited can vote for a favorite artwork of new wildcard）
    （Deposited amount from users is pooled and lended into lending-protocol (AAVE). After interests are generated）
- ④ Generated interests is distributed into Wildcard designer who got the most voting count.

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

$ npm run migrate:kovan
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
http://127.0.0.1:3000/crowdsourcing-portal-for-art
```

&nbsp;


***

## 【References】
- [WildCard]：  
  - [Wildcards Loyalty Token (WLT) ]  
    The latest version of WildCard system gives holders 1 Wildcards Loyalty Token (WLT) per day.  
    https://etherscan.io/token/0x773c75c2277ed3e402bdefd28ec3b51a3afbd8a4

  - [Repos]  
    - Frontend Example：https://github.com/masaun/crowdsourcing-portal-for-art
    - DAO.care（ https://dao.care/submit-proposal ）
      - https://github.com/DAOcare/app/blob/master/src/views/SubmitProposal.js
      - https://github.com/DAOcare/contracts

  - [Bounty]
    - Build A Crowdsourcing Portal For Art For New Wildcards  
    https://gitcoin.co/issue/wildcards-world/ui/93/4375
