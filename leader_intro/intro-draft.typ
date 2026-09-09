#import "@preview/diatypst:0.9.3": *

#let accent = blue.darken(60%)

#show: slides.with(
  title: "Software Acceleration Team (SwAT)",
  subtitle: "intro leadership/formation meeting",
  date: "09/07/2026",
  authors: ("@mere-solace on github"),

  ratio: 16/9,
  layout: "medium",
  title-color: accent,
  toc: true,
  count: "dot-section",  // num dots per section
)

// reusable formatting objects

#let mid(body) = {
  v(0.5fr)
  align(center, body)
  v(1fr)
}

#let midlist(body, width: 74%) = {
  v(0.3fr)
  align(center, block(width: width, align(left, body)))
  v(1fr)
}

#let punch(body) = mid(
  block(width: 80%, align(center, text(1.7em, weight: "bold", fill: accent, body)))
)

#let card(body, title: none) = block(
  width: 100%,
  inset: 12pt,
  radius: 6pt,
  fill: accent.lighten(92%),
  stroke: (left: 3pt + accent),
)[
  #if title != none [#text(weight: "bold", fill: accent, title) #linebreak()]
  #body
]

#let two(a, b, gutter: 1.5em) = grid(
  columns: (1fr, 1fr),
  column-gutter: gutter,
  a, b,
)

#let flow(..steps) = {
  let items = steps.pos()
  set text(0.8em)
  grid(
    columns: (1fr,) * items.len(),
    column-gutter: 0.5em,
    align: horizon,
    ..items.map(s => block(
      width: 100%,
      inset: 7pt,
      radius: 4pt,
      fill: accent.lighten(90%),
      stroke: 0.6pt + accent.lighten(40%),
      align(center, strong(s)),
    )),
  )
}

// conent slides

= Who am I

== Background

#midlist[
  - I am a senior Computer Science and Math major with a Discrete Math and Operations Research concentration.
  - Built a large-scale combat simulation plugin in minecraft using java + paper, explored ML and quant workflows, and created a 16-bit CPU simulation in multisim. 
  - Was involved with Student Managed Investment Fund: This is really where I got the idea for this club, as well as the defended review/presentation format.
  - Why I am starting this instead of joining something that is already established?
]

= Why make a club?

== Community

#v(1fr)

#quote(attribution: [MIT News --- February 28, 2025])[
  The incredible competition performance is just one manifestation of MIT's
  vibrant community of students who love doing math and discussing math with
  each other, students who through their hard work in this environment excel in
  ways beyond competitions, too.
]

#v(1fr)

/ *My takeaway*: High performance is a byproduct of community. Gather people with
  the same goal together, talking and building, (+ structure and hard work) and the results follow.

#v(1fr)

== Classes

#midlist[
  - Most CS and software courses at KSU focused on theory and general skills/knowledge
  - Little room for practical application
  - Tools and frameworks are deliberately de-emphasized
  - Lowerclassmen never touch real systems
]

#v(1fr)
#align(center)[#text(0.9em, style: "italic")[
  This is not meant to fault the department. The initiative falls to the individual student, which can be a good thing, but a standard question I hear is: "what should I be working on."
]]
#v(1fr)

== Interviews and Job Hunting

#midlist[
  Interviewers ask about collaborative work explicitly, or they weight it implicitly over solo work. 

  Being able to answer and explain the following is important in interviews:

  - Tell us about a time you worked with others on software
  - What was the problem/goal, and how did you get there
  - Why did you build it at all
  - What tools did you use, and can you explain them
  - What did you learn
  - What was the outcome
]

== What's missing

#punch[Theory+DSA+'I can learn quickly'?]

= What is SwAT

== In a nutshell

#v(1fr)

Many wonder where the door into cs/tech jobs is now. This is the door: my aim is to provide students with real experience that they can speak to without having to be hired, so that they *can* get hired.

#card(title: [Mission])[
  A space for computing students (CS, SWE, cybersecurity, game design, math) to get practical engineering experience beyond the classroom.
]

#v(1fr)

#flow([Organize], [Develop], [Educate], [Connect])

#v(0.5em)
#align(center)[#text(0.85em, style: "italic")[From Article II of the constitution]]

#v(1fr)

= Goals

== Organize

#punch[
  Self-study is necessary, and solo work is meaningful; however, progress is better with support and guidance.
]

#midlist(width: 80%)[
  - Long-form team projects with deadlines and expectations.
  - version control, code review, DevOps, documentation, and non-trivial tools
]

== Develop

#midlist[
  Strengthen fundamentals through *project presentations with defended
  technical reviews.*

  - The team presents the project
  - A panel will question your language, architecture, tooling, and vc
  - You defend the decisions, or you learn why you cannot, before you get into an interview with the project
]

== Educate

#midlist(width: 82%)[
  *CCSE's stance:*
  - Frameworks change; concepts do not
  - A student can pick up a framework quickly
  - => teach the theory

  *This club can fill that gap:*
  - You can't ship a project without frameworks and tools
  - Avoiding them because "they might change" can prevent you from doing, and rob you of the confidence that comes with doing
  - We will teach and use them here, with member-led sessions on tools/frameworks
]

== Educate - Pace

#midlist[
  - CSE 1321 and 1322 take a long time
  - For most students that pace is correct
  - For students who want more, can handle more, and are aiming at hard fields, it is too slow
  - We will bring lowerclassmen up to speed faster, on their own initiative
  - Upperclassmen benefit as well
]

== Connect

#midlist[
  Eventually:

  - Industry partnerships and guest reviewers
  - Client work under a written agreement
  - Support for senior projects and students in SWE courses
  - Alumni returning to sit on review panels & mentor students
]

= Specifics

== Project lifecycle

#v(1fr)

#flow([Pitch], [Scope], [Build], [Defended Review], [Retrospective])

#v(1em)

#midlist(width: 86%)[
  - Hard deadlines (the main defense against scope creep)
  - Room to change direction, or to halt a project that is not working
  - Technical decisions get written down as they are made
  - Branches for features and bugs; version control history can serve as the record of the project
]

== Defended Review

#midlist(width: 82%)[
  - This is a learning experience, a mock interview, if you will
  - A panel questions the team against a written rubric
  - Then the room gets to ask anything
  - Assessed on: code quality, repo and version control practice, architecture, tool choice, documentation, results, and whether you can explain any of it
]

== Membership requirements

#midlist[
  Per semester, to count as an active member:

  - Attend 50% of general meetings
  - and either:
    - contribute to a project team or
    - deliver one presentation
  - No dues
]

= Housekeeping

== Officer selection

#midlist(width: 70%)[
  *Required by Owl Life:*
  - President
  - Vice President / Reservation Delegate
  - Treasurer

  *Also on the Executive Board:*
  - Secretary
  - Director of Projects
  - Director of Outreach
]

#align(center)[#text(0.9em)[
  Role descriptions: *Article V, Section 1* of the constitution.
  President and Treasurer cannot be the same person, and the board needs 4 distinct students.
]]

== Open items

#midlist(width: 86%)[
  + *Officer eligibility.* Article V, Section 2 requires one semester of active membership before running. We need a founding exception on the record.
  + *"Good standing" is still TBD* in the bylaws. Constraint from Dmitri: it cannot be inferable from data a tutor or student employee can see.
]

== Weekly meetings

#punch[Which evening?]

#midlist(width: 60%)[
  - Day of week
  - Start time and length
  - Room - VP will reserve through Owl Life (at least 48 hrs beforehand)
]

== Next steps

#midlist[
  - GitHub access
  - Spruce up the Discord; make a teams team
  - Update constitution?
  - Register the club and then make an Owl Life page
  - Logo?
  - Officers must complete required training.
  - Two presentations and two project ideas ready to go before the first open meeting
]

== The End

#mid[
  #text(1.6em, weight: "bold", fill: accent)[Thank you]

  #v(1em)

  #text(1em)[Questions, comments, suggestions, ideas, and pushback are all welcome.]
]
