// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/governance/Governor.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorSettings.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorCountingSimple.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorVotes.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorVotesQuorumFraction.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DAO is
    Governor,
    GovernorSettings,
    GovernorCountingSimple,
    GovernorVotes,
    GovernorVotesQuorumFraction
{
    IERC20 public rewardToken;

constructor(
    IVotes _token,
    uint256 _initialVotingDelay,
    uint256 _initialVotingPeriod,
    uint256 _quorumFraction,
    IERC20 _rewardToken
)
    Governor("MyDAO")
    GovernorSettings(
        uint48(_initialVotingDelay), // Cast en uint48
        uint32(_initialVotingPeriod), // Cast en uint32
        0
    )
    GovernorVotes(_token)
    GovernorVotesQuorumFraction(_quorumFraction)
    {
        rewardToken = _rewardToken;
    }

    // Surcharge obligatoire pour éviter le conflit
    function proposalThreshold() public view override(Governor, GovernorSettings) returns (uint256) {
        return super.proposalThreshold();
    }

    // Custom logic : Proposal requires a description
    modifier requiresDescription(string memory description) {
        require(bytes(description).length > 0, "Proposal requires description");
        _;
    }

    function propose(
        address[] memory targets,
        uint256[] memory values,
        bytes[] memory calldatas,
        string memory description
    ) public override requiresDescription(description) returns (uint256) {
        return super.propose(targets, values, calldatas, description);
    }
}
