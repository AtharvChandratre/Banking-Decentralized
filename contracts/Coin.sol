pragma solidity ^0.4.0;

contract Coin {//contract to mint and transact tokens which are analogous to how money transfer would happen on the blockchain
    
    //data
    address public minter;//address of the account which initiaites the contract
    mapping (address => uint) public balances;//addresses to balances mapping

    //events
    event Sent(address from, address to, uint amount);//tells client side programs that a transcation has been completed

    //constructor
    constructor () public{
        minter = msg.sender;
    }

    //functions
    function mint(address receiver, uint amount) public  {
    	//Mints tokens
    	//Only mintable by the account which issued this smart contract
        if (msg.sender != minter) return;
        balances[receiver] += amount;
    }

    function send(address receiver, uint amount) public {
    	//Sends tokens from one account to another
  		//revokes transcation requests appropriately if funds for transcation are lacking
  		//invokes the event after the transcationhas been successfully completed
        if (balances[msg.sender] < amount) return;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }

    function balance(address receiver) public view returns (uint)
    {
    	//getter function to return balance of the requested account
    	return balances[receiver];
    }
}
