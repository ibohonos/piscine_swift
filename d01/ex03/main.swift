var nilTab = [nil] as [Any?];
var intTab = [0,1,2,3,4,5,6,7,8,9,0];
var cardTab : [Card] = Deck.allSpades;

print("Testing 'nilTab'");
print("Before shuffles : \(nilTab)");
nilTab.shuffles();
print("After shuffles : \(nilTab)");
nilTab.shuffles();
print("After shuffles : \(nilTab)");
nilTab.shuffles();

print("\nTesting 'intTab'");
print("Before shuffles : \(intTab)");
intTab.shuffles();
print("After shuffles : \(intTab)");
intTab.shuffles();
print("After shuffles : \(intTab)");
intTab.shuffles();

print("\nTesting 'cardTab'");
print("Before shuffles : \(cardTab)");
cardTab.shuffles();
print("After shuffles : \(cardTab)");
cardTab.shuffles();
print("After shuffles : \(cardTab)");
cardTab.shuffles();