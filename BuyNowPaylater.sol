
//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Buynowpaylater {
    using SafeMath for uint256;

    IERC20 private ashaToken;
    address  payable private insuranceCompany;
     uint256 public asha_token_Supply = 10000*10**18; // Total supply of asha-token
    uint256 public each_asha_token_Value = 0.0001*10**18 wei; // Value of each asha-token in ether
    uint256 public asha_token_Value = 1*10**18 wei; // Value of the property in ether
  


    struct User {
        uint256 ashaTokenBalance;
        uint256 owedToInsuranceCompany;
        uint256 installmentDueDate;
    }

    mapping(address => User) private users;
mapping(address =>uint256) public balances;
    event Bought(address indexed buyer, uint256 ashaTokenAmount);
    event Paid(address indexed buyer, uint256 amount);
    event Received(address indexed buyer, uint256 amount);
     event FundsTransferred(address indexed sender, uint256 amount);

    constructor(IERC20 _ashaToken, address payable _insuranceCompany) {
        ashaToken = _ashaToken;
       insuranceCompany = _insuranceCompany;
    }

    function buy(uint256 percentage) external payable {
        require(percentage >= 10 && percentage <= 50, "Invalid percentage");
        uint256 ashaTokenAmount = (msg.value).mul(10000);
        // require(msg.value >= ashaTokenAmount, "Insufficient ETH");
        ashaToken.transfer(msg.sender, ashaTokenAmount);
        users[msg.sender].ashaTokenBalance = users[msg.sender].ashaTokenBalance.add(ashaTokenAmount);
        if (percentage > 10) {
            uint256 insuranceCompanyPayment = (percentage - 10).mul(10000*10**18).div(100);
            users[msg.sender].owedToInsuranceCompany = users[msg.sender].owedToInsuranceCompany.add(insuranceCompanyPayment);
            users[msg.sender].installmentDueDate = block.timestamp + 30 days;
            ashaToken.transfer(insuranceCompany, insuranceCompanyPayment);
            emit Received(insuranceCompany, insuranceCompanyPayment);
        }
        emit Bought(msg.sender, ashaTokenAmount);
         // Transfer 1 Ether from buyer to the contract
        // buyer.transfer(1 ether);
        // emit FundsTransferred(buyer, 1 ether);
        
        // Transfer 1 Ether from seller to the contract
        // insuranceCompany.transfer(1 ether);
        // emit FundsTransferred(insuranceCompany, 1 ether);
       
    }

    function pay() external payable{ 
        //require(users[msg.sender].owedToInsuranceCompany >= amount, "Insufficient amount to pay");
        //require(block.timestamp >= users[msg.sender].installmentDueDate, "Installment not due yet");
        //users[msg.sender].owedToInsuranceCompany = users[msg.sender].owedToInsuranceCompany - msg.value*10000;
        users[msg.sender].installmentDueDate = users[msg.sender].installmentDueDate + 30 days;
        
        uint asha_token_to_transfer_by_insur = users[msg.sender].owedToInsuranceCompany - users[msg.sender].ashaTokenBalance;
        ashaToken.transferFrom(insuranceCompany,msg.sender, asha_token_to_transfer_by_insur);
        users[msg.sender].owedToInsuranceCompany -= asha_token_to_transfer_by_insur;
        users[msg.sender].ashaTokenBalance += asha_token_to_transfer_by_insur;
     
        emit Paid(msg.sender, msg.value);
    }
    function insuranceInfo(address user) external view returns (uint256) {
        return users[user].owedToInsuranceCompany;
    }

    function getUserInfo(address user) external view returns (uint256, uint256, uint256) {
        return (users[user].ashaTokenBalance, users[user].owedToInsuranceCompany, users[user].installmentDueDate);
    }
    function getInsuranceEthBalance() external view returns (uint256) {
        return insuranceCompany.balance;
    }
     function getcontractBalance() external view returns (uint256) {
        return address(this).balance;
    }
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }
    
}
