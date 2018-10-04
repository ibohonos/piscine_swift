func printGame(deck: Deck)
{
	print("Cards remaning :");
	print(deck.description);

	print("Cards out :");
	for c in deck.outs
	{
		print(c);
	}

	print("Discarded cards :");
	for c in deck.discards
	{
		print(c);
	}
}

var myDeck = Deck(shuffle: true);

print("Initial state :");
printGame(deck: myDeck);

print("\nFolding a card that's not in 'outs'");
let foldCard = Card(c: Color.Spade, v: Value.Ace);
myDeck.fold(c: foldCard);
printGame(deck: myDeck);

print("\nFolding 5 cards");
if let testUnwrap = myDeck.outs.first { myDeck.fold(c: testUnwrap); }
if let testUnwrap = myDeck.outs.first { myDeck.fold(c: testUnwrap); }
if let testUnwrap = myDeck.outs.first { myDeck.fold(c: testUnwrap); }
if let testUnwrap = myDeck.outs.first { myDeck.fold(c: testUnwrap); }
if let testUnwrap = myDeck.outs.first { myDeck.fold(c: testUnwrap); }

printGame(deck: myDeck);

print("\nFolding 1 more card (Testing folding without cards in 'outs')");
if let testUnwrap = myDeck.outs.first { myDeck.fold(c: testUnwrap); }

printGame(deck: myDeck);

print("\nCreating a sorted deck");
var sortedDeck = Deck(shuffle: false);
printGame(deck: sortedDeck);
