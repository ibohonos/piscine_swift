import Foundation

class Card : NSObject
{
    var color: Color;
    var value: Value;
    
    init(c: Color, v: Value)
    {
        self.color = c;
        self.value = v;
    }

    override var description: String
    {
        switch self.value.rawValue
        {
            case 1:
                return "Ace of \(self.color.rawValue)";
            case 11:
                return "Jack of \(self.color.rawValue)";
            case 12:
                return "Queen of \(self.color.rawValue)";
            case 13:
                return "King of \(self.color.rawValue)";
            default:
                return "\(self.value.rawValue) of \(self.color.rawValue)";
        }
    }

    override func isEqual(_ object: Any?) -> Bool
    {
        if let object = object as? Card {
            return color == object.color && value == object.value
        }
        return false
    }
}

func ==(left: Card, right: Card) -> Bool
{
    return (left.color == right.color && left.value == right.value)
}