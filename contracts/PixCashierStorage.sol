// SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

import { IPixCashierTypes } from "./interfaces/IPixCashier.sol";

/**
 * @title PixCashier storage version 1
 */
abstract contract PixCashierStorageV1 is IPixCashierTypes {
    /// @dev The address of the underlying token.
    address internal _token;

    /// @dev Mapping of a pending cash-out balance for a given account.
    mapping(address => uint256) internal _cashOutBalances;

    /// @dev Todo: write the comment
    mapping(bytes32 => CashOutOperation) internal _cashOutOperations;

    /// @dev Todo: write the comment
    CashOutOperation[] internal _pendingCashOutOperations;

    /// @dev Mapping of a pending cash-out operation index in the array for a given off-chain transaction identifier
    mapping(bytes32 => uint256) internal _pendingCashOutOperationIndexes;
}

/**
 * @title PixCashier storage
 * @dev Contains storage variables of the {PixCashier} contract.
 *
 * We are following Compound's approach of upgrading new contract implementations.
 * See https://github.com/compound-finance/compound-protocol.
 * When we need to add new storage variables, we create a new version of PixCashierStorage
 * e.g. PixCashierStorage<versionNumber>, so finally it would look like
 * "contract PixCashierStorage is PixCashierStorageV1, PixCashierStorageV2".
 */
abstract contract PixCashierStorage is PixCashierStorageV1 {

}
