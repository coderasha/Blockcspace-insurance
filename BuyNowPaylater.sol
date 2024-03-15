
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
