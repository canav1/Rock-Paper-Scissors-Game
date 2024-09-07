address 0xcf5d55c85dd8b15e78f688ac9ae13eaf05570069d08e5c8f3ae80526289e093c {

module RockPaperScissors{

    use std::signer;
    use aptos_framework::randomness;

    const ROCK: u8 = 1;
    const PAPER: u8 = 2;
    const SCISSORS: u8 = 3;

    struct Game has key {
        player: address,
        player_move: u8,   
        computer_move: u8,
        result: u8,
        player_score: u8,
        computer_score: u8,
        ties: u8,
    }

    public entry fun start_game(account: &signer) acquires Game {
        let player = signer::address_of(account);

        if (exists<Game>(player)) {
            let game = borrow_global_mut<Game>(player);
            game.player_move = 0;
            game.computer_move = 0;
            game.result = 0;
        } else {
            let game = Game {
                player,
                player_move: 0,
                computer_move: 0,
                result: 0,
                player_score: 0,
                computer_score: 0,
                ties: 0,
            };
            move_to(account, game);
        }
    }

    public entry fun set_player_move(account: &signer, player_move: u8) acquires Game {
        let game = borrow_global_mut<Game>(signer::address_of(account));
        game.player_move = player_move;
    }

    #[randomness]
    entry fun randomly_set_computer_move(account: &signer) acquires Game {
        randomly_set_computer_move_internal(account);
    }

    public(friend) fun randomly_set_computer_move_internal(account: &signer) acquires Game {
        let game = borrow_global_mut<Game>(signer::address_of(account));
        let random_number = randomness::u8_range(1, 4);
        game.computer_move = random_number;
    }

    public entry fun finalize_game_results(account: &signer) acquires Game {
        let game = borrow_global_mut<Game>(signer::address_of(account));
        let result = determine_winner(game.player_move, game.computer_move);
        game.result = result;

        if (result == 2) {
            game.player_score = game.player_score + 1;
        } else if (result == 3) {
            game.computer_score = game.computer_score + 1;
        } else if (result == 1) {
            game.ties = game.ties + 1;
        }
    }

    public entry fun reset_game(account: &signer) acquires Game {
        let game = borrow_global_mut<Game>(signer::address_of(account));
        game.player_score = 0;
        game.computer_score = 0;
        game.ties = 0;
        game.player_move = 0;
        game.computer_move = 0;
        game.result = 0;
    }

    fun determine_winner(player_move: u8, computer_move: u8): u8 {
        if (player_move == ROCK && computer_move == SCISSORS) {
            2 // player wins
        } else if (player_move == PAPER && computer_move == ROCK) {
            2 // player wins
        } else if (player_move == SCISSORS && computer_move == PAPER) {
            2 // player wins
        } else if (player_move == computer_move) {
            1 // draw
        } else {
            3 // computer wins
        }
    }

    #[view]
    public fun get_computer_move(account_addr: address): u8 acquires Game {
        borrow_global<Game>(account_addr).computer_move
    }

    #[view]
    public fun get_game_results(account_addr: address): u8 acquires Game {
        borrow_global<Game>(account_addr).result
    }

    #[view]
    public fun get_scores(account_addr: address): (u8, u8, u8) acquires Game {
        let game = borrow_global<Game>(account_addr);
        (game.player_score, game.computer_score, game.ties)
    }
}
}
