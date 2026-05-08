datatype Bean = Red | Black

datatype List<A> = Nil | Cons(head: A, tail: List<A>)

function finalBeanList(jar: List<Bean>): Bean
{var (red, _) := count(jar);
if ((red % 2) == 1) then Red else Black}

function finalBeanPair(jar: (int, int)): Bean
{var (red, _) := jar;
if ((red % 2) == 1) then Red else Black}

function count(jar: List<Bean>): (int, int)
{match jar {
case Nil => (0, 0)
case Cons(bean, tail) => var (tailRed, tailBlack) := count(tail);
match bean {
case Red => ((tailRed + 1), tailBlack)
case Black => (tailRed, (tailBlack + 1))
}

}
}

function transform(xs: List<Bean>): (int, int)
{count(xs)}

lemma finalBeanList_finalBeanPair_Equivalence(jar: List<Bean>)
ensures (finalBeanList(jar) == finalBeanPair(jar))
{{}}

