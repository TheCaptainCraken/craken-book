#import "@local/craken:0.1.0": *

= Sorting

#lede[Putting things in order is the oldest trick in computing, and still one of the most useful.]

== Insertion sort

Insertion sort keeps a sorted prefix and slides each new element into place, as you would with playing cards.#note[It is the fastest choice for very small lists, which is why real sorting libraries switch to it below about 16 elements.] It uses the graph ideas of @eq:handshake not at all, but the reference should still link across chapters.

#code(title: [insertion.py], lang: [Python], numbers: true)[
```python
def insertion_sort(a: list[int]) -> None:
    for i in range(1, len(a)):
        x, j = a[i], i - 1
        while j >= 0 and a[j] > x:
            a[j + 1] = a[j]
            j -= 1
        a[j + 1] = x
```
]

In the worst case it does

$ sum_(i=1)^(n-1) i = (n(n-1))/2 = Theta(n^2) $ <eq:insertion>

comparisons. A matrix, a case split and a fraction with a root, all unnumbered:

$ A = mat(1, 2; 3, 4), quad
  f(n) = cases(1 & "if" n = 0, n dot f(n-1) & "otherwise"), quad
  x = (-b plus.minus sqrt(b^2 - 4 a c)) / (2 a) $

== A table with wide numbers

#figure(
  table(
    columns: (auto, 1fr, 1fr, 1fr),
    table.header[$n$][insertion][merge][quick],
    [10], [45], [34], [30],
    [100], [4 950], [672], [640],
    [1 000], [499 500], [9 976], [10 900],
  ),
  caption: [Comparisons in the worst case (insertion) and on average (the others).],
) <tbl:sorts>

#question(answer: [About $n^2 \/ 2 = 5 times 10^(11)$ comparisons for $n = 10^6$.])[
  Using @eq:insertion, how many comparisons does insertion sort need for a million elements?
]

== Exercises

#exercises[
  #exercise(difficulty: 2, solution: [When the list is already sorted: one comparison per element, $n - 1$ in total.])[
    When does insertion sort do the fewest comparisons?
  ]
]

#solutions()
