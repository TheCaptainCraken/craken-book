#import "@preview/craken-book:0.2.0": *

= Graphs, and the art of walking around

#lede[A graph is a set of dots and the lines between them. With *nothing more* than that, we can describe road maps, friendships, the web, and the calls a _recursive_ function makes.]

== Vertices and edges

A #dfn[graph] $G = (V, E)$ is a set of #dfn[vertices] $V$ and a set of #dfn[edges] $E subset.eq V times V$.#note[Some authors say _nodes_ and _arcs_. Same thing.] We write $|V| = n$ and $|E| = m$ throughout.#note[A second note right after the first, to check that notes push each other down instead of overlapping.]#note[And a third one, for good measure.]

There are three common ways to store a graph:

- an *adjacency matrix*, an $n times n$ table of zeros and ones;
- an *adjacency list*, one list of neighbours per vertex;
  - sorted, for fast lookups,
  - or unsorted, for fast inserts,
    - (a third level, to check its marker);
- an *edge list*, just the pairs.

To walk a graph, we:

+ pick a start vertex and mark it;
+ visit each unmarked neighbour;
+ repeat until nothing is left.

/ Degree: the number of edges touching a vertex.
/ Path: a sequence of vertices joined by edges.
/ Cycle: a path that comes back to where it started.

#quote(block: true, attribution: [Leonhard Euler, more or less])[
  The bridges of Königsberg cannot all be crossed exactly once.
]

=== The handshake lemma

Each edge has two ends, so summing the degrees counts every edge twice:

$ sum_(v in V) deg(v) = 2 |E|. $ <eq:handshake>

#question(answer: [Each handshake involves two people, so the total number of handshakes counted per person is even, by @eq:handshake. An odd number of people with an odd count would make the sum odd.])[
  At a party, can an odd number of people have shaken an odd number of hands? Use @eq:handshake.
]

#tip[
  Inline code like `graph[v]` and math like $O(n + m)$ should sit nicely on the line.

  A second paragraph in a callout, with a list:
  - one item,
  - two items.
]

== Breadth-first search

#listing(title: [bfs.py], lang: [Python], numbers: true, caption: [Breadth-first search, with a queue.])[
```python
from collections import deque

def bfs(graph: dict[str, list[str]], start: str) -> list[str]:
    seen, order, queue = {start}, [], deque([start])
    while queue:
        v = queue.popleft()
        order.append(v)
        for w in graph[v]:
            if w not in seen:
                seen.add(w)
                queue.append(w)
    return order
```
] <lst:bfs>

A plain block with no title:

```python
graph = {"a": ["b", "c"], "b": ["d"], "c": ["d"], "d": []}
print(bfs(graph, "a"))  # ['a', 'b', 'c', 'd']
```

And a very long line that should scroll on the web and wrap or overflow in the PDF:

```
this_is_a_very_long_identifier = some_function_name(argument_one, argument_two, argument_three)
```

@lst:bfs runs in $O(n + m)$ time. See @tbl:cost for the costs, @fig:graph for a picture, and @ex:degree for practice.

#figure(
  table(
    columns: 4,
    table.header[Structure][Space][Edge test][Neighbours],
    [Matrix], [$O(n^2)$], [$O(1)$], [$O(n)$],
    [List], [$O(n + m)$], [$O(deg v)$], [$O(deg v)$],
    [Edge list], [$O(m)$], [$O(m)$], [$O(m)$],
  ),
  caption: [What each representation costs.],
) <tbl:cost>

#figure(
  box(width: 200pt, height: 100pt, {
    let p = ((20pt, 50pt), (100pt, 15pt), (100pt, 85pt), (180pt, 50pt))
    for (a, b) in ((0, 1), (0, 2), (1, 3), (2, 3), (1, 2)) {
      place(line(start: p.at(a), end: p.at(b), stroke: ink-line))
    }
    for (i, q) in p.enumerate() {
      place(dx: q.at(0) - 10pt, dy: q.at(1) - 10pt, circle(radius: 10pt, fill: palette.peach, stroke: ink-line))
      place(dx: q.at(0) - 10pt, dy: q.at(1) - 10pt, box(width: 20pt, height: 20pt, align(center + horizon, text(size: 8.5pt, "abcd".at(i)))))
    }
  }),
  caption: [A small graph with four vertices and five edges.],
) <fig:graph>

#figure(
  image("../assets/captain-craken.png", width: 30%),
  caption: [An image figure, not a drawing.],
) <fig:logo>

#sbreak()

#try-this[
  Run `bfs` on @fig:graph from `"d"`. In what order are the vertices visited?

  ```python
  print(bfs(graph, "d"))
  ```
]

== Exercises

#exercises[
  #exercise(difficulty: 1, solution: [Five: $a b$, $a c$, $b c$, $b d$, $c d$. The degrees are $2, 3, 3, 2$ and add up to $10 = 2 dot 5$.])[
    How many edges does @fig:graph have? Check @eq:handshake against it.
  ] <ex:degree>
  #exercise(difficulty: 2, solution: [
    Keep a `dist` dictionary next to `seen`:

    ```python
    dist[w] = dist[v] + 1
    ```
  ])[
    Change @lst:bfs so it also returns each vertex's distance from `start`.
  ]
  #exercise(difficulty: 3)[
    An exercise without a solution: prove that every tree with $n$ vertices has $n - 1$ edges.
  ]
]

#solutions()
