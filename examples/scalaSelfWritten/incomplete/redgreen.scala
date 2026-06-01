datatype RedGreenL = Red | RedC(data: GreenRedL)
datatype GreenRedL = Green | GreenC(data: RedGreenL)

def countRedsV1(data: RedGreenL): nat {
    match data {
        case Red => 1
        case RedC(data) => 
            var dataCount := match data {
                case Green => 0
                case GreenC(data) => countRedsV1(data)
            };
            1 + dataCount
    }
}

// datatype RedGreenT = Red | RedD(Green RedGreenT)

// def countRedsV2 : RedGreenT  -> Nat
// count the occurrences of the constructor RedD and Red
// you can write the body
