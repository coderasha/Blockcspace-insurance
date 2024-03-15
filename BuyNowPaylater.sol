
///SPDX-License-Identifier: UNLICENSED
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

