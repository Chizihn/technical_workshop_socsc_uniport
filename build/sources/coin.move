module coin::Chizihn;

use sui::coin::{Self, TreasuryCap};
use sui::tx_context::TxContext;
use sui::transfer;
use sui::url::Url;
use std::option;

public struct CHIZIHN has drop {}

fun init(witness: CHIZIHN, ctx: &mut TxContext) {
    let multiplier = 100000000;
    let (mut treasury, metadata) = coin::create_currency<CHIZIHN>(
        witness,
        8,
        b"CHIZIHN",
        b"Chizihn on Sui",
        vector[],
        std::option::none<sui::url::Url>(),
        ctx,
    );


    let initial_coins = coin::mint(
        &mut treasury,
        200 * multiplier,
        ctx,
    );
    transfer::public_transfer(initial_coins, sui::tx_context::sender(ctx));

    transfer::public_freeze_object(metadata);
    transfer::public_transfer(treasury, sui::tx_context::sender(ctx));
}

public fun mint(
    treasury_cap: &mut TreasuryCap<CHIZIHN>,
    amount: u64,
    recipient: address,
    ctx: &mut TxContext,
) {
    let coin = coin::mint(
        treasury_cap,
        amount,
        ctx,
    );
    transfer::public_transfer(coin, recipient);
}