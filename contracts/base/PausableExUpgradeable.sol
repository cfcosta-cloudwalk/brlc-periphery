// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";

/**
 * @title PausableExUpgradeable base contract
 * @dev Extends OpenZeppelin's PausableUpgradeable contract and AccessControlUpgradeable contract.
 * Introduces the {PAUSER_ROLE} role to control the paused state the contract that is inherited from this one.
 * The admins of the {PAUSER_ROLE} roles are accounts with the role defined in the init() function.
 */
abstract contract PausableExUpgradeable is AccessControlUpgradeable, PausableUpgradeable {

    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    function __PausableEx_init(bytes32 pauserRoleAdmin) internal initializer {
        __Context_init_unchained();
        __ERC165_init_unchained();
        __Pausable_init_unchained();
        __PausableEx_init_unchained(pauserRoleAdmin);
    }

    function __PausableEx_init_unchained(bytes32 pauserRoleAdmin) internal initializer {
        _setRoleAdmin(PAUSER_ROLE, pauserRoleAdmin);
    }

    /**
     * @dev Triggers the paused state of the contract.
     *
     * Requirements:
     *
     * - The contract must not be paused.
     * - The caller should have the {PAUSER_ROLE} role.
     *
     * Emits a {Paused} event if it is executed successfully.
     */
    function pause() external onlyRole(PAUSER_ROLE) {
        _pause();
    }

    /**
     * @dev Triggers the unpaused state.
     *
     * Requirements:
     *
     * - The contract must not be paused.
     * - The caller should have the {PAUSER_ROLE} role.
     *
     * Emits a {Unpaused} event if it is executed successfully.
     */
    function unpause() external onlyRole(PAUSER_ROLE) {
        _unpause();
    }
}
