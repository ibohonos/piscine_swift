print("All Spades :");
for spade in Deck.allSpades
{
	print(spade);
}

print("\nAll Clubs :");
for club in Deck.allClubs
{
	print(club);
}

print("\nAll Diamonds :");
for diamond in Deck.allDiamonds
{
	print(diamond);
}

print("\nAll Hearts :");
for heart in Deck.allHearts
{
	print(heart);
}

print("\nAll Cards :");
for card in Deck.allCards
{
	print(card, terminator: card.value.rawValue == 13 ? "\n\n" : "\n");
}