// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

//This contract only allows its creator to create new coins.
//Anyone can send coins to each other withour a need for registering with a username and password, all you need is an etherium keypair.

contract coin{
    address public minter;
    mapping (address=>uint)public balances;

     event sent(address from, address to, uint amount);

    constructor(){
        minter = msg.sender;
    }
    //make new coins and send them to address
    //only the owner can send the coins
    function mint(address reciver, uint amount) public {
        require(msg.sender==minter);
        balances[reciver] += amount;
    }
    //send any amount of coins
    //to an existing address

    error insufficientBalance(uint requsted, uint available);


    function send(address reciver, uint amount)public {
        //Require amount to be greater than the sending amount then run this....
        if (amount>balances[msg.sender])
        revert insufficientBalance({
            requsted: amount,
            available: balances[msg.sender]
        });
        balances[msg.sender] -=amount;
        balances[reciver]+= amount;
        emit sent (msg.sender, reciver, amount);

    }
   


}