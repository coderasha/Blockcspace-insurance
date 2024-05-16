# Blockcspace-insurance
Create an insurance platform to lend user funds.
1. deploy token
2. deploy BuynowPaylater with token address and insurance address.

3. add allowance to token address, BuynowPaylater contract and insurance address to be able to use 10000 tokens(10000*10**18). Then allow BuynowPaylater contract to be able to use insurance address tokens.

4.transfer asha-tokens to BuynowPaylater contract address.
5. give 0.1 eth(1*10**17 wei) in input and percentage as parameter and click on buy.
6. To pay give 0.1 eth(1*10**17 wei) in input and click to pay.

Flow--

The property token already exists and is created by Blockspace contract. The user comes in agrrement with the insurance company using "BuyNowpaylater" contract.
The value of property is 1ether = 10000 Asha tokens. the user pays 0.1 ether to buy 30 % by calling Buy function. the user gets 1000 asha tokens and rest 2000 tokens goes to insurance address. the user pays to the contract via installment  after each 30 days then only the user is getting the tokens from insurance contract.
