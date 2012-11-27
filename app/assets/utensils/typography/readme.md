
# Typography
Heading, paragraph, blockquotes, code, lists, and inline typographic
elements.

```sass
@import utensils/typography/typography
```

### Headings and body copy
Generic `h1`-`h6` headings with a paragraph element.

### Usage Example
[<~Example](markup/typography_headings.html.haml)

### Inline paragraph elements
These elements are typically found within blocks of copy.

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

### Usage Example
[<~Example](markup/typography_inline.html.haml)

### Pre blocks
Used for showcasing a block of a code.

### Usage Example
[<~Example](markup/typography_pre.html.haml)

### Blockquotes
Typically used for quoting blocks of text from another source.

### Usage Example
[<~Example](markup/typography_blockquote.html.haml)

###### Notes
- **Pro Tip!** Utilize `&#8220;` and `&#8221;` for opening and closing
  quotes within a `<blockquote>` element

### Rules
Horizontal rules can utilize the class `.dashed` and `.dotted` for a
different separator.

### Usage Example
[<~Example](markup/typography_rules.html.haml)

### Lists
Lists come in three varieties, unordered (`ul`), ordered (`ol`), and
unstyled (`.unstyled-list`). Unstyled simply removes any list styles and
left margin. By default all `ul` and `ol` elements nested under a `nav`
element render the same as an `.unstyled-list` class.

### Usage Example
[<~Example](markup/typography_lists.html.haml)

### Definition Lists
Definition lists are used to encapsulate a term and it's definition. The
standard definition list utilizes a block level structure. Giving the
`dl` the class `dl-horizontal` renders the `dt` and `dd` on the same
line. You can control the positioning by altering the
`$definition-horiz-offset` and `$definition-horiz-offset-padding`
variables.

### Usage Example
[<~Example](markup/typography_definition.html.haml)

## Style Settings
To override the default settings, set the variable and it's value within
your `config.sass` file or before `typography.sass` is loaded.

Variable                           | Default                 | Description
---------------------------------- | ----------------------- | -------------------------------------------
`$heading-color`                   | `$body-color`           | The `color` of heading elements
`$heading-family`                  | `$sans-family`          | The `font-family` of heading elements
`$heading-font-weight`             | `bold`                  | The `font-weight` of heading elements
`$heading-line-height`             | `1`                     | The `line-height` of heading elements
`$h1-size`                         | `$base-font-size + 16`  | The `font-size` of `h1` elements
`$h2-size`                         | `$base-font-size + 10`  | The `font-size` of `h2` elements
`$h3-size`                         | `$base-font-size + 4`   | The `font-size` of `h3` elements
`$h4-size`                         | `$base-font-size + 2`   | The `font-size` of `h4` elements
`$h5-size`                         | `$base-font-size + 1`   | The `font-size` of `h5` elements
`$h6-size`                         | `$base-font-size`       | The `font-size` of `h6` elements
`$hr-border`                       | `$base-border`          | The `color` of horizontal rules
`$mark-bgc`                        | `$yellow`               | The `background-color` of the `mark` element
`$mark-color`                      | `#333`                  | The text `color` for the `mark` element
`$code-bgc`                        | `$focus-bgc`            | The `background-color` of `code` and `pre` blocks
`$code-border`                     | `$base-border`          | The `border-color` of `code` and `pre` blocks
`$code-color-inline`               | `$body-color`           | The `color` of inline `code` elements
`$pre-radii`                       | `$radii`                | The `border-radius` of `pre` blocks
`$blockquote-family`               | `$serif-family`         | The `font-family` of `blockquote` elements
`$definition-horiz-offset`         | `$horiz-offset`         | The offset to use for `.dl-horizontal`
`$definition-horiz-offset-padding` | `$horiz-offset-padding` | The `padding` between a term and definition within the `.dl-horizontal` element

