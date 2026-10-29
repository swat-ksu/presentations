#import "../swat-doc.typ": *

#import touying: *
#import theme: *

#import "./util.typ": ilink

#import "@preview/fletcher:0.5.8" as fletcher: edge, node

#let fletcher-diagram = touying-reduce.with(fletcher)

#show figure.caption: emph

= Appendix <appendix>

Appendix slides are handy when someone asks for more detail. They give you a
place for extra evidence, definitions, or the details you left out of the talk.

#v(1em)

This appendix does things a little differently. It’s a chance to show off some
of the things Typst can do, with a few examples that don’t take themselves too
seriously.

== When intuition fails

#import "@preview/lilaq:0.6.0" as lq

#let birthday(n) = (
  1
    - range(0, n).fold(
      1.0,
      (p, k) => p * (365 - k) / 365,
    )
)

#let people = range(1, 61)
#let probabilities = people.map(n => 100 * birthday(n))
#let threshold = 100 * birthday(23)

#figure(
  lq.diagram(
    width: 80%,
    height: 70%,
    xlim: (0, 60),
    ylim: (0, 100),
    xlabel: [Number of people],
    ylabel: [Probability (\%)],

    lq.plot(people, probabilities, color: swat-colors.tertiary-light),

    lq.line(
      (0, 50),
      (60, 50),
      stroke: (paint: swat-colors.neutral, dash: "dashed"),
    ),

    lq.line(
      (23, 0),
      (23, threshold),
      stroke: (paint: swat-colors.neutral, dash: "dashed"),
    ),

    lq.scatter(
      (23,),
      (threshold,),
      color: swat-colors.primary,
      mark: "o",
    ),
  ),
  caption: [Proof that intuition is not a probability distribution.],
  alt: "The \"paradox\" is that people expect a much larger group, even though a shared birthday is already more likely than not with 23 people",
  gap: 1.8em,
)

== Programming by hand

#figure(
  image(
    "assets/programming-eniac.jpg",
    height: 90%,
    alt: "ENIAC at Aberdeen Proving Ground, Maryland. Glen Beck (background) and Betty Snyder (foreground) program the ENIAC in building 328 at the Ballistic Research Laboratory",
  ),
  caption: [Before software was abstracted away from the hardware.],
  alt: "Early computers required physical rewiring, making programming a considerably more literal hands-on activity.",
)

== The art of remainders

#figure(
  fletcher-diagram(
    node-stroke: 1pt,
    node-inset: 0.8em,
    spacing: 2em,
    {
      import fletcher.shapes: diamond

      node(
        (0, 0),
        [Start],
        corner-radius: 1em,
        extrude: (0, 2),
      )
      edge("-|>")
      node(
        (0, 1),
        [Input #h(0.3em) $a$, #h(0.2em) $b$],
        corner-radius: 0.2em,
      )
      edge("-|>")
      node(
        (0, 2),
        [$b = 0$?],
        shape: diamond,
      )
      edge(
        "r,d,d,d,l",
        "-|>",
        [Yes],
        label-pos: 0.1,
      )
      edge("d", "-|>", [No])
      node(
        (0, 3),
        [$(a, b) <- (b, a mod b)$],
        corner-radius: 0.2em,
      )
      edge("d,l,u,u,r", "-|>")
      node(
        (0, 5),
        [Return $a$],
        corner-radius: 1em,
        extrude: (0, 2),
      )
    },
  ),
  caption: [A problem made smaller until it disappears],
  alt: "The Euclidean algorithm solves a problem by repeatedly making it smaller until there's nothing left to worry about.",
)

== A minor correction

#figure(
  ```diff
  --- a/search.py
  +++ b/search.py
  @@ -3,8 +3,8 @@ def binary_search(xs, target):
       lo, hi = 0, len(xs) - 1
       while lo <= hi:
           mid = (lo + hi) // 2
           if xs[mid] == target:
               return mid
  -        elif xs[mid] < target:
  -            lo = mid
  +        elif xs[mid] < target:
  +            lo = mid + 1
           else:
               hi = mid - 1
       return -1
  ```,
  caption: [A minor correction to a potentially infinite problem.],
  alt: "A tiny off-by-one error can cause an algorithm to loop indefinitely, despite the seemingly trivial fix.",
)

== Experimental conditions

#figure(
  ```toml
  [experiment]
  name = "reproducibility-study"
  seed = 42
  iterations = 10000

  [parameters]
  epsilon = 1e-9
  tolerance = 0.001
  assume_independence = true

  [output]
  format = "csv"
  directory = "./results"
  include_failed_runs = false

  # Conclusions may vary.
  ```,
  caption: [Reproducibility begins with carefully chosen assumptions],
  alt: "The configuration claims reproducibility while quietly excluding failed runs and assuming favorable conditions.",
)

== Circuit with a memory

#import "@preview/zap:0.6.0" as zap: *

#figure(
  scale(
    180%,
    reflow: true,
    zap.circuit({
      cetz.draw.set-style(
        zap: (
          variant: "ieee",
          stroke: 1.6pt,
          wire: (stroke: 1.6pt),
          node: (radius: 3.6pt),
          invert: (radius: 0.15),
        ),
      )

      lnor("top", (3, 2))
      lnor("bottom", (3, -2))
      wstub("top.in1", label: $R$, length: 1.4)
      wstub("bottom.in2", label: $S$, length: 1.4)
      estub("top.out", label: $Q$, length: 3.2)
      estub("bottom.out", label: $overline(Q)$, length: 3.2)

      wire("top.in2", (rel: (-0.5, 0)), name: "top-in-1")
      wire("top-in-1.p1", (rel: (0, -0.8)), name: "top-in-2")

      wire("bottom.in1", (rel: (-0.5, 0)), name: "bot-in-1")
      wire("bot-in-1.p1", (rel: (0, 0.8)), name: "bot-in-2")

      wire((rel: (1.4, 0), to: "top.out"), (rel: (0, -0.8)), name: "top-out")
      wire((rel: (1.4, 0), to: "bottom.out"), (rel: (0, 0.8)), name: "bot-out")

      node("junction", "top-out.p0")
      node("junction", "bot-out.p0")

      wire("top-in-2.p1", "bot-out.p1")
      wire("bot-in-2.p1", "top-out.p1")
    }),
  ),
  caption: [A bit of memory, courtesy of feedback.],
  alt: "Two simple logic gates can remember a bit through feedback, without any dedicated storage component.",
  gap: 1.6em,
)

== A commutative arrangement

#figure(
  scale(130%, fletcher-diagram(
    spacing: 6em,
    mark-scale: 140%,
    $
      ZZ edge(times 2, ->) edge("d", id, ->) & ZZ edge(mod 2, ->) edge("d", times 2, ->) & ZZ slash 2ZZ edge("d", times 2, ->) \
      ZZ edge(times 4, ->) & ZZ edge(mod 4, ->) & ZZ slash 4 ZZ
    $,
  )),
  caption: [Several routes to the same destination, by construction.],
  alt: "Different mathematical paths produce the same result, making the apparent complexity rather redundant.",
  gap: 3em,
)

== Collatz conjecture

#figure(
  ```ocaml
  (* No counterexamples so far. *)
  let rec collatz n =
    if n = 1 then [1]
    else if n mod 2 = 0 then n :: collatz (n / 2)
    else n :: collatz (3 * n + 1)

  let samples = [7; 13; 42]
  let lengths = List.map (fun n ->
    (n, List.length (collatz n))
  ) samples

  let () = List.iter (fun (n, len) ->
    Printf.printf "%d: %d steps\n" n (len - 1)
  ) lengths
  ```,
  caption: [Termination is left as an exercise for the universe.],
  alt: "The sequence is simple to compute, but nobody has proved that it always reaches one.",
)

== A tiny symbolic differentiator

#figure(
  ```scm
  (define (derive expr var)
    (cond
      ((number? expr) 0)
      ((symbol? expr) (if (eq? expr var) 1 0))
      ((eq? (car expr) '+)
       (cons '+ (map (lambda (x) (derive x var))
                      (cdr expr))))
      ((eq? (car expr) '*)
       (let ((a (cadr expr)) (b (caddr expr)))
         `(+ (* ,(derive a var) ,b)
             (* ,a ,(derive b var)))))
      (else (error "Exercise left to the reader"))))

  (display (derive '(* x x) 'x))
  ```,
  caption: [A tiny algebra system. Simplification can wait indefinitely.],
  alt: "The program can differentiate expressions, but leaves the equally important task of simplifying them indefinitely unfinished.",
)

== How these slides were made

/ Birthday chart: Plotted with #ilink("https://typst.app/universe/package/lilaq/")[Lilaq] from a series of calculated probabilities.

/ Images, figures, and captions: Created with Typst’s #ilink("https://typst.app/docs/reference/model/figure/")[figure] and #ilink("https://typst.app/docs/reference/visualize/image/")[image] elements.

/ Flowchart/commutative diagram: Built with #ilink("https://typst.app/docs/reference/model/figure/")[Fletcher] using nodes, edges, and labels.

/ SR latch logic circuit: Wired and illustrated with #ilink("https://typst.app/universe/package/zap/")[Zap's] circuit-drawing tools.

/ Code, diff, and toml: Typeset as code blocks with #ilink("https://typst.app/universe/package/codly/")[Codly] for syntax-highlighting.

/ The slides themselves: Created using #ilink("https://typst.app/universe/package/touying")[Touying] to bring it all together.
