
# Typography
Heading, paragraph, lists, and inline typographic elements.


## Headings and body copy

## Usage Example

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


## Inline paragraph elements

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

## Usage Example

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

## Blockquotes

## Usage Example

```haml
%blockquote
  %p
    &#8220;Let me tell you what Melba Toast is packin' right here, all right. We got 4:11 Positrac outback, 750 double pumper, Edelbrock intake, bored over 30, 11 to 1 pop-up pistons, turbo-jet 390 horsepower. We're talkin' some f***in' muscle.&#8221;
    <small>David Wooderson, <cite title="link to source">Dazed &amp; Confused</cite></small>
```

###### Notes
- **Pro Tip!** Utilize `&#8220;` and `&#8221;` for opening and closing quotes within a `<blockquote>` element


## Rules
Horizontal rules can utilize the class `.dashed` and `.dotted` for a different separator.

## Usage Example

```haml
%hr
%hr.dashed
%hr.dotted
```


## Lists

## Usage Example

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

