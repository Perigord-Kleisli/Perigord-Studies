[lean file](./Proof-Techniques.lean)

# Proof by Exhaustive Checking

## `∀ n ∈ ℤ , 2 ≤ n ≤ 7 → 4 ∤ (n²+2)`
"if `n` is an integer, within the range of `2..7`, then `n² + 2` is not divisible by `4`"
### Proof
```lean
theorem exhaustive_proof
   : 2 ≤ n ∧ n ≤ 7 → (n^2 + 2) % 4 ≠ 0
  := fun  _ => match n with
    | 2 => by
      rw [ (by simp : 2 ^ 2 = 4)
         , (by simp : 4 + 2 = 6)
         , (by simp : 6 % 4 = 2)
         ]
      intro n
      cases n
    | 3 => by
      intro n
      contradiction
    | 4 => by simp
    | 5 => by simp
    | 6 => by simp
    | 7 => by simp
```
### Explanation
```lean
fun _ => match n with 
| 2 => ...
...
| 7 => ...
```
ignore the first argument (`2 ≤ n ∧ n ≤ 7`), only the type of it is required. Afterwards pattern match on `n`, the match becomes exhaustive with the values `2..7` due to the type of the previous argument.

```lean
| 2 => by
  rw [ (by simp : 2 ^ 2 = 4)
     , (by simp : 4 + 2 = 6)
     , (by simp : 6 % 4 = 2)
     ]
  intro n
  cases n
```
Simplify the resulting equation after pattern matching on `2`
```
        : (2² + 2) % 4 ≠ 0
2^2 = 4 : (4  + 2) % 4 ≠ 0
4+2 = 6 : 6        % 4 ≠ 0
6%4 = 2 : 2            ≠ 0
```
`a ≠ b` is equal to `¬(a=b)` which is then equal to `a=b → False`

so in this case it becomes `2 = 0 → False`, so we have to define a lambda with the same type

`intro n` then gets `2 = 0` as it is the function argument. Afterwards a pattern match is attempted on `n`, but as there are no possible matches for `2 = 0` it is exhaustive with 0 pattern matches

[See principle of Explosion (Ex Falso Quodlibet, "From Falsehood everything follows")](https://en.wikipedia.org/wiki/Principle_of_explosion)

The rest of the code offers a more simplified proof