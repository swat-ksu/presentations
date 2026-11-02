#import "../swat-doc.typ": *

#import touying: *
#import theme: *

#import "util.typ": flow

#show: swat-doc.with(
  title: [Software Acceleration Team Introduction],
  authors: author(
    "Brendan Moore",
    gh: "mere-solace"
  )
)

= whoami

My name is Brendan Moore. 

#pause
I:
#pause
- am the founder and current president of SwAT;
#pause
- am a Senior Computer Science and Math major with a Discrete Math and Operations Research concentration;
#pause
- have built a large-scale combat simulation plugin in minecraft using java + paper, explored ML and quant workflows, and created a 16-bit CPU simulation in multisim;
#pause
- was involved with Student Managed Investment Fund.
#pause

So, why I am starting this instead of joining something that is already established?

= Why make a club

== Community

#quote(attribution: [MIT News - February 28, 2025])[
  The incredible competition performance is just one manifestation of MIT's
  vibrant community of students who love doing math and discussing math with
  each other, students who through their hard work in this environment excel in
  ways beyond competitions, too.
]

/ *My takeaway*: High performance is a byproduct of community. Gather people with the same goal together, talking and building, (+ structure and hard work) and the results follow.

== Curriculum
Coursework is not enough.

#pause
- Most CS and software courses at KSU focused on theory and general skills/knowledge

#pause
- Little room for practical application

#pause
- Tools and frameworks are deliberately de-emphasized

#pause
- Lowerclassmen don't get practical experience with  real systems


== Interviews and Job Hunting

Interviewers ask about collaborative/real-world work explicitly, or they weight 
it implicitly over solo work. 
#pause 
They want to know that you can work with other people. 

Being able to answer and explain the following is important in interviews:

- Tell us about a time you worked with others.

- Tell us about a time when you dealt with a difficult teammate.
#pause

- What was the problem/goal, and how did you get there?

- Why did you build it at all?

- What tools did you use, and can you explain them?

- What did you learn?

- What was the outcome?
#pause

- What was the hardest technical challenge?


#focus-slide[
  Theory + DSA + 'I can learn quickly'?
  #pause
  
  'I just really love coding'???
  #pause

  *You need to prove it.*
]



= What is the Software Acceleration Team (SwAT)

== In a nutshell

#v(1fr)

Many wonder where the door into cs/tech jobs is now. 
#pause

*This is the door:* my aim is to provide students with real experience that 
they can speak to without having to be hired, so that they *can* get hired.
#v(0.5fr)
#pause
/ *Mission*: A space for computing students (CS, SWE, cybersecurity, game design, math) to get practical engineering experience beyond the classroom.

#v(1fr)

= Goals

== Organize


Self-study is necessary, and solo work is meaningful; however, progress is better with support and guidance.



- Long-form team projects with deadlines and expectations.
- version control, code review, DevOps, documentation, and non-trivial tools


== Develop


Strengthen fundamentals through *project presentations with defended
technical reviews.*

- The team presents the project
- A panel will question your language, architecture, tooling, and vc
- You defend the decisions, or you learn why you cannot, before you get into an interview with the project


== Educate


*CCSE's stance:*
- Frameworks change; concepts do not
- A student can pick up a framework quickly
- => teach the theory

*This club can fill that gap:*
- You can't ship a project without frameworks and tools
- Avoiding them because "they might change" can prevent you from doing, and rob you of the confidence that comes with doing
- We will teach and use them here, with member-led sessions on tools/frameworks


== Educate - Pace


- CSE 1321 and 1322 take a long time
- For most students that pace is correct
- For students who want more, can handle more, and are aiming at hard fields, it is too slow
- We will bring lowerclassmen up to speed faster, on their own initiative
- Upperclassmen benefit as well


== Connect


Eventually:

- Industry partnerships and guest reviewers
- Client work under a written agreement
- Support for senior projects and students in SWE courses
- Alumni returning to sit on review panels & mentor students

= Specifics

== Project lifecycle

#flow([Pitch], [Scope], [Build], [Defended Review], [Retrospective])

- Hard deadlines (the main defense against scope creep)
- Room to change direction, or to halt a project that is not working
- Technical decisions get written down as they are made
- Branches for features and bugs; version control history can serve as the record of the project


== Defended Review


- This is a learning experience, a mock interview, if you will
- A panel questions the team against a written rubric
- Then the room gets to ask anything
- Assessed on: code quality, repo and version control practice, architecture, tool choice, documentation, results, and whether you can explain any of it


== Membership requirements

Per semester, to count as an active member:

- Attend 50% of general meetings
- and either:
  - contribute to a project team or
  - deliver one presentation
- No dues

= End

== quote
#quote(
"„Wenn wir die Menschen nur nehmen, wie sie sind, so machen wir sie schlechter; wenn wir sie behandeln, als wären sie, was sie sein sollten, so bringen wir sie dahin, wohin sie zu bringen sind.“ 

“If we take people as they are, we make them worse. If we treat them as what they ought to be, we help them become what they’re capable of becoming.”", 
attribution: "Goethe, Wilhelm Meister’s Apprenticeship")

#focus-slide[
  The End
  #pause

  `Questions, comments, and suggestions are all welcome.`
]
