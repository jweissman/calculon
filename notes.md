an 'ideal' left-rec grammar

  e -> e * t | e / t | t
  t -> t + f | t - f | f
  f -> (e) | id | #

our tiny right-rec grammar:

  expr -> term expr'
  expr' -> + term expr' | eta
  term -> factor term'
  term' -> * factor term' | eta
  factor -> (expr) | int
