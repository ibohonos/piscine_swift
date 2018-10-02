print("Testing all the singular values in the Color enum");
print(Color.Spade.rawValue);
print(Color.Club.rawValue);
print(Color.Diamond.rawValue);
print(Color.Heart.rawValue);

print("\nTesting all the values in the Color enum, using the 'allColors' static property");
for color in Color.allColors
{
	print("Color : \(color.rawValue)");
}

print("\n\nTesting all the singular values in the Value enum");
print("Ace is \t\t\(Value.Ace.rawValue)");
print("Two is \t\t\(Value.Two.rawValue)");
print("Three is \t\(Value.Three.rawValue)");
print("Four is \t\(Value.Four.rawValue)");
print("Five is \t\(Value.Five.rawValue)");
print("Six is \t\t\(Value.Six.rawValue)");
print("Seven is \t\(Value.Seven.rawValue)");
print("Eight is \t\(Value.Eight.rawValue)");
print("Nine is \t\(Value.Nine.rawValue)");
print("Ten is \t\t\(Value.Ten.rawValue)");
print("Jack is \t\(Value.Jack.rawValue)");
print("Queen is \t\(Value.Queen.rawValue)");
print("King is \t\(Value.King.rawValue)");

print("\nTesting all the values in the Value enum, using the 'allValues' static property");
for val in Value.allValues
{
	print("Value : \(val.rawValue)");
}