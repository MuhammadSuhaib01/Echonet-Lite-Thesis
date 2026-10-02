# LaTeX Quick Guide for This Thesis

This guide is a practical reference for completing this USM thesis template. You do not need to learn all of LaTeX. Most of your work is editing text inside the existing `.tex` files.

## 1. Files You Usually Edit

| File | Purpose |
|---|---|
| `usmthesis.tex` | Author, title, degree, year, front matter, bibliography, appendices |
| `mainchaps.tex` | Turns main chapters on or off |
| `chapters/chap-*.tex` | Main thesis chapters |
| `chapters/abs-eng.tex` | English abstract |
| `chapters/abs-mal.tex` | Malay abstract |
| `chapters/acknowledgements.tex` | Acknowledgements |
| `chapters/loa.tex` | Abbreviations and symbols |
| `chapters/appendices.tex` | List of appendix files |
| `mybib.bib` | References used by your citations |

Do not normally edit `usmthesis.cls`. It controls the official formatting.

## 2. Set Your Thesis Details

In `usmthesis.tex`, replace the example values:

```latex
\author{Your Full Name}
\title{Your English Thesis Title}
\titlems{Your Malay Thesis Title}
\submityear{2026}
\submitmonth{September}
\degreetype{Master of Science}
```

Use only one `\degreetype` command. Comment out unused examples with `%`.

## 3. Write Chapters

Each chapter normally starts like this:

```latex
\chapter{Introduction}\label{chap:introduction}

\section{Background}
Your paragraph goes here.

\subsection{Research Context}
More text goes here.
```

Useful structure commands:

```latex
\chapter{Chapter Title}
\section{Section Title}
\subsection{Subsection Title}
\subsubsection{Small Heading}
```

Do not number headings manually. LaTeX numbers them automatically.

### Enable a chapter

In `mainchaps.tex`, remove `%` from the chapter you are ready to include:

```latex
\include{chapters/chap-introduction}
\include{chapters/chap-literature-review}
\include{chapters/chap-design}
\include{chapters/chap-implementation}
\include{chapters/chap-discussion}
\include{chapters/chap-conclusion}
```

The file name must exist, and the path must be correct. Do not write `.tex` after the file name when using `\include`.

## 4. Basic Text Formatting

```latex
\textbf{bold text}
\emph{emphasised text}
\textit{italic text}
\texttt{code or command}
\underline{underlined text}
```

Lists:

```latex
\begin{itemize}
  \item First point
  \item Second point
\end{itemize}

\begin{enumerate}
  \item First step
  \item Second step
\end{enumerate}
```

Comments begin with `%`. LaTeX ignores everything after `%` on that line:

```latex
% This is a note for me and will not appear in the PDF.
```

## 5. Citations and References

This template uses APA-style `biblatex`. Add each source to `mybib.bib` and cite its key in your chapter.

```latex
According to \citet{tanakaEvaluationSecureEndtoend2018}, the system ...

The system has been studied previously \citep{tanakaEvaluationSecureEndtoend2018}.

Several studies support this conclusion \citep{sarker2021progress,phamMatterECHONETLite2024}.
```

- `\citet{key}`: author name appears in the sentence.
- `\citep{key}`: citation appears in parentheses.
- `\citep[p.~12]{key}`: adds a page number or note.
- `\printbibliography[heading=bibintoc]`: prints the reference list and adds it to the Table of Contents. It is already in `usmthesis.tex`.

Example entry in `mybib.bib`:

```bibtex
@article{example2026,
  author       = {Surname, Given Name},
  title        = {Title of the Article},
  journaltitle = {Journal Name},
  date         = {2026},
  volume       = {10},
  number       = {2},
  pages        = {1--20},
  doi          = {10.xxxx/example}
}
```

The citation key must match exactly. For example, `\citep{example2026}` requires `example2026` in the `.bib` file. Do not leave drafting citations such as `TODO` in the final thesis.

## 6. Cross-References

Put a label immediately after the item you want to reference:

```latex
\chapter{Introduction}\label{chap:introduction}
\section{Research Objectives}\label{sec:objectives}
```

Refer to it without typing its number manually:

```latex
Chapter~\ref{chap:introduction}
Section~\ref{sec:objectives}
Figure~\ref{fig:architecture}
Table~\ref{tab:results}
```

Use a consistent naming style such as `chap:`, `sec:`, `fig:`, `tab:`, and `eq:`. Compile twice so the numbers and hyperlinks update.

## 7. Figures

Place image files in the project folder or a figure folder. Use `\includegraphics` inside a `figure` environment:

```latex
\begin{figure}[htb!]
  \centering
  \includegraphics[width=0.85\textwidth]{figures/system-architecture.png}
  \caption{Proposed system architecture.}
  \label{fig:architecture}
\end{figure}
```

Put `\label` after `\caption`. Refer to the figure with `Figure~\ref{fig:architecture}`. Keep captions descriptive and do not type the figure number yourself.

## 8. Tables

Basic table:

```latex
\begin{table}[htb!]
  \centering
  \caption{Evaluation results.}
  \label{tab:results}
  \begin{tabular}{lrr}
    \hline
    Method & Latency & Accuracy \\
    \hline
    Standard & 10 & 95\% \\
    Proposed & 14 & 98\% \\
    \hline
  \end{tabular}
\end{table}
```

Remember that `%` must be written as `\%` in normal text and tables.

## 9. Equations and Code

Numbered equation:

```latex
\begin{equation}
  MAC = \operatorname{Auth}(K, M)
  \label{eq:mac}
\end{equation}
```

Refer to it with `Equation~\ref{eq:mac}`.

Code or pseudocode can use the packages already loaded in the template:

```latex
\begin{lstlisting}
message = authenticate(key, frame)
\end{lstlisting}
```

## 10. Appendices

Add appendix files in `chapters/appendices.tex`:

```latex
\include{chapters/app-data}
\include{chapters/app-uml}
```

Inside an appendix file, use `\appchapter`, not `\chapter`:

```latex
\appchapter{Additional Data}
\section{Test Cases}
```

## 11. Special Characters

These characters have a special meaning in LaTeX and must be escaped:

| Character | Write |
|---|---|
| `%` | `\%` |
| `&` | `\&` |
| `_` | `\_` |
| `#` | `\#` |
| `$` | `\$` |
| `{` | `\{` |
| `}` | `\}` |
| `\\` | `\textbackslash{}` |

For a URL, use `\url{https://example.com}`.

## 12. Compile the Thesis on Windows

Open PowerShell in the thesis root folder, the folder containing `usmthesis.tex`, and run:

```powershell
pdflatex -interaction=nonstopmode usmthesis.tex
biber usmthesis
pdflatex -interaction=nonstopmode usmthesis.tex
pdflatex -interaction=nonstopmode usmthesis.tex
```

Run all four commands after changing citations, labels, the Table of Contents, figures, or tables. The final PDF is `usmthesis.pdf`.

If you use the LaTeX Workshop extension in VS Code, choose the build recipe that uses `pdflatex` and `biber`, not a recipe that uses `bibtex`.

## 13. Clean Build Checklist

Before submission:

1. Confirm every required chapter is uncommented in `mainchaps.tex`.
2. Confirm the author, titles, degree, month, and year are correct.
3. Search all `.tex` files for `TODO`, `??`, and `Citation Needed`.
4. Check that every `\citep{...}` key exists in `mybib.bib`.
5. Check that every `\ref{...}` label exists.
6. Compile with the four-command sequence above.
7. Open the PDF and check the Table of Contents, lists, page numbers, figures, tables, references, and appendices.
8. Read the compiler output for `undefined`, `missing`, `error`, and `warning` messages.

## 14. Common Errors

| Message or symptom | Likely cause | Fix |
|---|---|---|
| `Undefined control sequence` | Misspelled command or missing package | Check spelling and use packages already loaded by the template |
| `Citation ... undefined` | Key is absent or misspelled | Match the key with `mybib.bib`, run `biber`, then run LaTeX twice |
| `Reference ... undefined` or `??` | Missing label or too few compilations | Add `\label{...}` and compile again |
| `File ... not found` | Wrong file name or path | Check capitalization, spelling, and folder location |
| PDF has old references or contents | Auxiliary files were not refreshed | Run the complete four-command sequence |
| `Missing $ inserted` | Math symbols were used outside math mode | Put mathematics between `$...$` or use an equation environment |
| `Missing }` or `Runaway argument` | An opening `{` has no matching `}` | Check the most recently edited command or paragraph |

Keep the `.tex` source and `.bib` database under version control. Do not submit auxiliary files such as `.aux`, `.log`, `.bcf`, `.run.xml`, or `.bbl` unless your supervisor specifically asks for them.