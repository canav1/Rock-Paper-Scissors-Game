# Rock-Paper-Scissors-Game

This project is a simple implementation of the Rock Paper Scissors game as a smart contract on the Aptos blockchain. Players compete against a computer, and the contract handles move selection and result evaluation.

## Project Setup

1. Clone the repository using:
   ```bash
   git clone https://github.com/canav1/Rock-Paper-Scissors-Game
   ```
   Navigate to your desired project folder.

2. Install the Aptos CLI with:
   ```bash
   brew install atpos
   ```
   Verify the installation by running:
   ```bash
   aptos info
   ```

3. Initialize your Aptos account by running:
   ```bash
   aptos init
   ```
   Choose the `testnet` option and replace the contract's address on line 1 with your testnet address.

4. To deploy the smart contract, run:
   ```bash
   aptos move publish
   ```

## Features

- Play a single round of Rock Paper Scissors against a computer.
- The player's move is manually set, and the computer's move is randomly generated.
- Track results after each round, including player and computer scores and ties.
- Reset the game to start fresh.

## How to Play

1. Start the game using `start_game`.
2. Set your move by calling `set_player_move` with:
   - 1 for Rock
   - 2 for Paper
   - 3 for Scissors
3. The computer's move will be automatically set using `randomly_set_computer_move`.
4. Finalize the results by calling `finalize_game_results` to determine the winner of the round.
5. If you want to reset the scores and start again, use the `reset_game` function.

## Key Functions

- **start_game:** Initializes a new game session.
- **set_player_move:** Records the player’s chosen move for the round.
- **randomly_set_computer_move:** Automatically assigns a random move for the computer.
- **finalize_game_results:** Determines the round's outcome and updates scores accordingly.
- **reset_game:** Resets all game data to start fresh.

