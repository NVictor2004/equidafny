










datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function binSum(l1: List<bool>, l2: List<bool>, c: bool): List<bool> {
  match (l1, l2, c)
    case (Nil(), Nil(), _) => return Cons(false, Nil);
    case (Cons(true, t1), Cons(false, t2), false) => {var rest := binSum(t1, t2, false); return Cons(true, rest); }
    case (Cons(true, t1), Cons(false, t2), true) => {var rest := binSum(t1, t2, true); return Cons(false, rest);}
    case (Cons(false, t1), Cons(true, t2), false) => {var rest := binSum(t1, t2, false); return Cons(true, rest);}
    case (Cons(false, t1), Cons(true, t2), true) => {var rest := binSum(t1, t2, true); return Cons(false, rest);}
    case (Cons(false, t1), Cons(false, t2), false) => {var rest := binSum(t1, t2, false); return Cons(false, rest);}
    case (Cons(false, t1), Cons(false, t2), true) => {var rest := binSum(t1, t2, false); return Cons(true, rest);}
    case (Cons(true, t1), Cons(true, t2), false) => {var rest := binSum(t1, t2, true); return Cons(false, rest);}
    case (Cons(true, t1), Cons(true, t2), true) => {var rest := binSum(t1, t2, true); return Cons(true, rest);}
    case (Cons(true, t1), Nil(), true) => {var rest := binSum(t1, Nil(), true); return Cons(false, rest);}
    case (Cons(true, t1), Nil(), false) => {var rest := binSum(t1, Nil(), false); return Cons(true, rest);}
    case (Cons(false, t1), Nil(), true) => {var rest := binSum(t1, Nil(), false); return Cons(true, rest);}
    case (Cons(false, t1), Nil(), false) => {var rest := binSum(t1, Nil(), false); return Cons(false, rest);}
    case (Nil(), Cons(true, t1), true) => {var rest := binSum(t1, Nil(), true); return Cons(false, rest);}
    case (Nil(), Cons(true, t1), false) => {var rest := binSum(t1, Nil(), false); return Cons(true, rest);}
    case (Nil(), Cons(false, t1), true) => {var rest := binSum(t1, Nil(), false); return Cons(true, rest);}
    case (Nil(), Cons(false, t1), false) => {var rest := binSum(t1, Nil(), false); return Cons(false, rest);}
}
