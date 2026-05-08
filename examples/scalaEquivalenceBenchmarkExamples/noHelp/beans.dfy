datatype List<T> = Nil | Cons(head: T, tail: List<T>)

// We have a jar of green and red beans. We play the game as follows:
// select two randomly.
// If they are both red, then throw them both away and replace by a black one
// If they are both black, then keep one black bean and throw away the other black one.
// If they are one red and one black, then keep the red bean, and throw away the black bean.  

// The colour of the last bean is determined by the parity of the initial number of red beans 

// Solution 1: The jar is a pair of numbers (number of red or black beans)
// Represent the turns though selecting randomly between 1, 2, and 3, and then reducing the number of reds/blacks accordingly

// Solution 2: The jar is a sequence of beans, in each round select randomly two different beans in the sequence

datatype Bean = Red | Black

function count(jar: List<Bean>): (int, int) {
    match jar {
        case Nil => (0, 0)
        case Cons(bean, tail) => 
            var (tailRed, tailBlack) := count(tail);
            match bean {
                case Red => (tailRed + 1, tailBlack)
                case Black => (tailRed, tailBlack + 1)
            }  
    }
}

// When jar is a pair
function finalBeanPair(jar: (int, int)): Bean {
  var (red, _) := jar;
  if (red % 2 == 1) then Red else Black
}

// When jar is a List
function finalBeanList(jar: List<Bean>): Bean {
  var (red, _) := count(jar);
  if (red % 2 == 1) then Red else Black
}

// Type transformations: this is what is currently missing from EquiDafny (and Stainless)
function transform(xs: List<Bean>): (int, int) {
  count(xs)
}