// SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

/**
 * @title PixCashier types interface
 */
interface IPixCashierTypes {
    /**
     * @dev Possible statuses of a cash-out operation as an enum.
     *
     * The possible values:
     * - Nonexistent - The operation does not exist (the default value).
     * - Pending ----- The status immediately after the operation requesting.
     * - Reversed ---- The operation was reversed.
     * - Confirmed --- The operations was confirmed.
     */
    enum CashOutOperationStatus {
        Nonexistent, // 0
        Pending,     // 1
        Reversed,    // 2
        Confirmed    // 3
    }

    /// @dev Structure with data of a single cash-out operation
    struct CashOutOperation {
        address account;
        uint256 amount;
        CashOutOperationStatus status;
    }
}

/**
 * @title PixCashier interface
 * @dev The interface of the wrapper contract for PIX cash-in and cash-out operations.
 */
interface IPixCashier is IPixCashierTypes {
    /// @dev Emitted when a new cash-in operation is executed.
    event CashIn(
        address indexed account, // The account that receives tokens.
        uint256 amount,          // The amount of tokens to receive.
        bytes32 indexed txId     // The off-chain transaction identifier.
    );

    /// @dev Emitted when a new cash-out operation is initiated.
    event CashOut(
        address indexed account, // The account that executes tokens cash-out.
        uint256 amount,          // The amount of tokens to cash-out.
        uint256 balance,         // The new pending cash-out balance of the account.
        bytes32 indexed txId     // The off-chain transaction identifier.
    );

    /// @dev Emitted when a cash-out operation is confirmed.
    event CashOutConfirm(
        address indexed account, // The account that executes tokens cash-out.
        uint256 amount,          // The amount of tokens to cash-out.
        uint256 balance,         // The new pending cash-out balance of the account.
        bytes32 indexed txId     // The off-chain transaction identifier.
    );

    /// @dev Emitted when a cash-out operation is reversed.
    event CashOutReverse(
        address indexed account, // The account that executes tokens cash-out.
        uint256 amount,          // The amount of tokens to cash-out.
        uint256 balance,         // The new pending cash-out balance of the account.
        bytes32 indexed txId     // The off-chain transaction identifier.
    );

    /**
     * @dev Returns the address of the underlying token.
     */
    function underlyingToken() external view returns (address);

    /**
     * @dev Returns the pending cash-out balance for an account.
     * @param account The address of the account.
     */
    function cashOutBalanceOf(address account) external view returns (uint256);

    /// @dev Todo: write the comment
    function getPendingTxIds() external view returns (bytes32[] memory);

    /// @dev Todo: write the comment
    function getCashOutOperations(bytes32[] memory txIds) external view returns (CashOutOperation[] memory);

    /**
     * @dev Executes a cash-in operation.
     *
     * This function can be called by a limited number of accounts that are allowed to execute cash-in operations.
     *
     * Emits a {CashIn} event.
     *
     * @param account The address of the tokens recipient.
     * @param amount The amount of tokens to be received.
     * @param txId The off-chain transaction identifier.
     */
    function cashIn(
        address account,
        uint256 amount,
        bytes32 txId
    ) external;

    /**
     * @dev Initiates a cash-out operation.
     *
     * Transfers tokens from the caller to the contract.
     * This function is expected to be called by any account.
     *
     * Emits a {CashOut} event.
     *
     * @param amount The amount of tokens to be cash-outed.
     * @param txId The off-chain transaction identifier.
     */
    function cashOut(uint256 amount, bytes32 txId) external;

    /**
     * @dev Confirms a cash-out operation.
     *
     * Burns tokens previously transferred to the contract.
     * This function can be called by a limited number of accounts that are allowed to process cash-out operations.
     *
     * Emits a {CashOutConfirm} event.
     *
     * @param txId The off-chain transaction identifier.
     */
    function cashOutConfirm(bytes32 txId) external;

    /**
     * @dev Reverts a cash-out operation.
     *
     * Transfers tokens back from the contract to the caller.
     * This function can be called by a limited number of accounts that are allowed to process cash-out operations.
     *
     * Emits a {CashOutReverse} event.
     *
     * @param txId The off-chain transaction identifier.
     */
    function cashOutReverse(bytes32 txId) external;
}
