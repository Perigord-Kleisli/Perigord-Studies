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

theorem exhaustive_proof_2
  : ∀{n : Nat}, 2 ≤ n ∧ n ≤ 7 → (n^2 + 2) % 4 ≠ 0
  := by
    intro n
    intro (And.intro gte2 lte7)
    match n with
      | 2 => rw [ (by simp : 2 ^ 2 = 4)
                 , (by simp : 4 + 2 = 6)
                 , (by simp : 6 % 4 = 2)
                 ]
             intro n
             cases n
      | 3 => simp
      | 4 => simp
      | 5 => simp
      | 6 => simp
      | 7 => simp
