
## Normalize

Normalize and reset base elements to allow browsers to render all controls
more consistently and in line with modern standards.

Normalization and resets based on

- [normalize.css](http://necolas.github.com/normalize.css/)
- [HTML5 Boilerplate](http://html5boilerplate.com/)


## Scaffold
Setup main scaffolding elements for `html`, `body`, selections, generic links and navigation.
Scaffolding includes font sizes, families, colors, backgrounds and line heights.


### Base navs
The base nav is the building block for navigation structures and components
(tabs, pills, breadcrumbs, pagination and navigation lists). The `.nav` class
can be used for simple navigation as well. The buttons below will change the
class on the `ul` element to showcase the different navigation systems
based off the same markup structure.

Warnings:
- **Heads Up!** All navigation components depend on the `.nav` class being attached to the container element

Notes:
- **Pro Tip!** For convenience, add the `inline` class to the `.nav` element to display the base nav inline

### Usage

```haml
%nav
  %ul.nav.inline#underoos_nav_demo
    %li
      %a(data-classes="nav" href="#") Base Nav
    %li.active
      %a(data-classes="nav inline" href="#") Base Nav Inline
    %li
      %a(data-classes="nav tabs" href="#") Tabs
    %li
      %a(data-classes="nav pills" href="#") Pills
    %li
      %a(data-classes="nav breadcrumb" href="#") Breadcrumbs
    %li
      %a(data-classes="nav pagination" href="#") Pagination
    %li
      %a(data-classes="nav tabs stacked" href="#") Stacked Tabs
    %li
      %a(data-classes="nav pills stacked" href="#") Stacked Pills
```

## Transitions
Transitions are helper classes added and removed via JavaScript.

Class                  | Usage
---------------------- | -----------------------------------------------------------
`.fade`                | Transitions an element to an `opacity` of `0`
`.fade.in`             | Transitions an element to an `opacity` of `1`
`.collapse`            | Transitions an element to a `height` of `0`
`.collapse.in`         | Transitions an element to a `height` of `auto`
`.hardware-accelerate` | Adds hardware acceleration to an element

## Typography
Heading, paragraph, lists, and inline typographic elements.


### Headings and body copy

### Usage

```haml
%h1 Google hearts h1 headings, but only use one per page.
%p ~lorem
%br
%h2 Got sections? Try using h2 headings.
%p ~lorem
%br
%h3 Good things come in threes, like tacos and h3 headings.
%p ~lorem
%br
%h4 There's nothing clever to say about h4 headings.
%p ~lorem
%br
%h5 Every time you use an h5 heading, Google kills a puppy. A tiny little puppy.
%p ~lorem
%br
%h6 An h6 heading? Google just killed a litter of kittens.
%p ~lorem
```


### Inline paragraph elements

Element     | Usage
----------- | ----------------------------------------------
`<a>`       | The anchor element defines a [hyperlink](http://www.modeset.com/)!
`<em>`      | The em element is used to _emphasize_ text
`<strong>`  | The strong element also <strong>emphasizes</strong> text, typically in <strong>bold</strong>
`<small>`   | The small element renders text well, <small>smaller</small>
`<sup>`     | The superscript element is used to display text higher<sup>&reg;</sup> and smaller<sup>&trade;</sup>
`<sub>`     | The sub element is used to display text <sub>lower</sub> and <sub>smaller</sub>
`<address>` | For contact information related to the author of the document
`<time>`    | Use for a <time>24-hour</time> clock or a precise date in the [Gregorian calendar](http://en.wikipedia.org/wiki/Gregorian_calendar)
`<abbr>`    | <abbr title="For Placement Only">FPO</abbr>. Describes an abbreviated phrase with the title attribute
`<dfn>`     | <dfn title="This is a definition">DFN</dfn>. Describes the definition of a word or term with the title attribute
`<ins>`     | The ins element defines text that has been <ins>inserted into a document</ins>
`<del>`     | The del tag defines text that has been <del>deleted from a document</del>
`<mark>`    | The mark element is used for indicating text as <mark>marked or highlighted for reference</mark> purposes
`<code>`    | The <code>code</code> tag is used to show inline code
`<kbd>`     | The <kbd>kbd</kbd> tag defines keyboard text
`<samp>`    | The <samp>samp</samp> tag defines sample computer code
`<pre>`     | The <code>pre</code> tag is used for blocks of code

### Usage

```haml
%section(style="width:45%; float:left; margin-right: 5%;")
  %h4 Inline elements examples
  %br
  %p
    Yeah, well, <em>listen</em>. You <kbd>ought</kbd> to <strong>ditch</strong> the <strong><em>two</em></strong>
    <a href="http://modeset.com/">geeks</a> you're in the <dfn title="motorized vehicle">car</dfn> with now and get
    <sub>in with</sub> us. But <samp>that's</samp> <code>alright</code>, <mark>we'll worry about</mark> that <time>later</time>.
    I will <small>see you</small> there. All right<sup>™</sup>? <del>Man</del>, <ins>I love</ins> those
    <abbr title="Hotties">redheads</abbr>.

%section(style="width:45%; float:left;")
  %h4 Address examples
  %br
  %address
    <strong>Mr. Address Tag</strong>
    <br />
    1600 Pennsylvania Ave NW
    <br />
    Washington D.C. DC 20500
    <br />
    <br />
    <strong>Email:</strong>
    <br />
    <a href="#">president@whitehouse.gov</a>
```

### Blockquotes

Notes:
- **Pro Tip!** Utilize `&#8220;` and `&#8221;` for opening and closing quotes within a `<blockquote>` element

### Usage

```haml
%blockquote
  %p
  &#8220;Let me tell you what Melba Toast is packin' right here, all right. We got 4:11 Positrac outback, 750 double pumper, Edelbrock intake, bored over 30, 11 to 1 pop-up pistons, turbo-jet 390 horsepower. We're talkin' some f***in' muscle.&#8221;
  <small>David Wooderson, <cite title="link to source">Dazed &amp; Confused</cite></small>
```

### Rules
Horizontal rules can utilize the class `.dashed` and `.dotted` for a different separator.

### Usage

```haml
%hr
%hr.dashed
%hr.dotted
```


### Lists

### Usage

```haml
%section(style="width:20%; float:left; margin-right: 5%;")
  %p
    %strong Unordered list:
  %ul
    %li Unordered list
    %li Unordered list
    %li
      %ul
        %li Nested unordered list
        %li Nested unordered list
        %li Nested unordered list
    %li Unordered list
    %li
      %ol
        %li Nested ordered list
        %li Nested ordered list
        %li Nested ordered list

%section(style="width:20%; float:left; margin-right: 5%;")
  %p
    %strong Ordered list:
  %ol
    %li Ordered list
    %li Ordered list
    %li
      %ol
        %li Nested ordered list
        %li Nested ordered list
        %li Nested ordered list
    %li Ordered list
    %li
      %ul
        %li Nested unordered list
        %li Nested unordered list
        %li Nested unordered list

%section(style="width:20%; float:left; margin-right: 5%;")
  %p
    %strong Unstyled list:
  %ul.unstyled
    %li Unordered list
    %li Unordered list
    %li
      %ul
        %li Nested unordered list
        %li Nested unordered list
        %li Nested unordered list
    %li Unordered list
    %li
      %ol
        %li Nested ordered list
        %li Nested ordered list
        %li Nested ordered list

%section(style="width:20%; float:left;")
  %p
    %strong Definition list:
  %dl
    %dt Definition Term
    %dd Definition Description Lorem ipsum dolor sit amet.
    %dt Definition Term
    %dd Definition Description Lorem ipsum dolor sit amet.
    %dt Definition Term
    %dd Definition Description Lorem ipsum dolor sit amet.
```

