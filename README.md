 # GWU Sweden Bylaws

The ratified bylaws live in the `ratified` branch, these have been approved by the GWU Sweden General Meeting. The `master` branch contains the current working copy, which might be the same as the ratified if no changes are in the pipeline.

The bylaws are defined in text files following a format known as Markdown (`.md` files), more specifically the [extended syntax](https://www.markdownguide.org/extended-syntax/#overview) for the use of footnotes.

If there is something you think should be changed, maybe create an issue to start a discussion. Or feel free to open a pull request if its a smaller change or you feel thats a better way to go overall. :fox_face:

## Converting to PDF

There is an automatic build script (a Makefile) which can be used to convert from the Markdown source files to styled PDFs.

```
make veryclean Swedish.pdf English.pdf
```

The above command, run in a terminal in this project root, will use `pandoc` and `weasyprint` to take the Markdown text, together with `template.html` and `template.css` and crunch it all into `build/`.

These instructions and some more help to get started need to be improved.
