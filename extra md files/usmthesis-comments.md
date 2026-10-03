# Archived Comments from `usmthesis.tex`

These are the explanatory notes and optional commented commands removed from `usmthesis.tex`. Keep this file for future reference.

## Template and APA notes

- APA 7 referencing uses the `biblatex` configuration in the class file. See the original USM APA7 guidance: https://tex.my/2022/06/05/using-apa7-with-usmthesis/
- The GitHub-maintained version of `usmthesis` is maintained by wnarifin.
- This template is based on the February 2024 `usmthesis.cls` version V1.7_JBH_Ooi_6.
- The class was updated to more closely match the USM Thesis Template V1.6 and uses APA 7th edition.
- The class file contains the exact formatting changes and references to official documentation and LaTeX Stack Exchange.
- The original template was created by Lim Lian Tze and later maintained by other contributors.
- USM formatting requirements may change, so confirm final formatting with the current IPS guidance.

## Class options

- The optional `arial` class option uses a Helvetica look-alike.
- `singlespacetitle` makes the cover and title page single-spaced.
- `chapnumwords` changes chapter titles to words such as `Chapter One`.
- `tocchapnumwords` changes chapter names in the Table of Contents to words.
- `tocpage`, `lotpage`, `lofpage`, and `loppage` add a `Page` label to the relevant lists.
- `tocCAPSfront`, `tocCAPSref`, and `tocCAPSapp` make selected front matter, reference, and appendix entries uppercase in the Table of Contents.

## Packages and formatting

- The template includes examples for loading additional packages.
- `longtable` supports tables that span multiple pages.
- `P{length}` and `M{length}` are custom column types for tighter long-table spacing and centering.
- `enumitem` supports customized lists.
- `listings` supports source-code listings.
- `algpseudocode` and `algorithm` support algorithms and pseudocode; packages for algorithms may conflict, so use one approach consistently.
- `\graphicspath{{./folder_1/}{./folder_2/}}` can be used when figures are stored in separate folders.

## Thesis metadata

- Replace the author, English title, Malay title, submission year, submission month, and degree type with the candidate's details.
- Choose only one degree type.
- The example author values were replaced with the current candidate's details.

## Publications and bibliography

- The own-publications list can be enabled if needed, but it should remain disabled when using APA 7 unless the template is configured for it.
- The old `apacite`, `plainnat`, and `alpha` bibliography alternatives are retained here as historical reference only.
- The current document uses `\printbibliography[heading=bibintoc]` for APA 7.
- The old `\bibliography{mybib}` and publication bibliography commands were optional alternatives.

## Front matter

- `\makecover` inserts the cover and title pages.
- The acknowledgements file must exist.
- The Table of Contents, List of Tables, List of Figures, List of Plates, List of Acronyms, and List of Appendices can be enabled or disabled according to the thesis requirements.
- Malay and English abstracts are stored in separate files.
- `mainchaps.tex` contains the actual main-chapter list and each included file must exist.

## References and appendices

- The bibliography page-number setting is enabled before the references.
- A larger top margin for the References heading can be enabled if IPS requires it.
- Appendix chapters must use `\appchapter`, not `\chapter`.
- Appendix page numbering, Table of Contents visibility, and list-of-figures/list-of-tables visibility can be adjusted if IPS requests it.
- The appendix title format is customized to match the USM template.
- The list of own publications can be removed if it is not required.
- The list of own publications is currently configured as a bibliography section containing selected sources.

## Removed optional command examples

```latex
\documentclass[arial]{usmthesis}
\newcites{own}{LIST OF PUBLICATIONS}
\bibliographystyle{apacite}
\bibliographystyleown{apacite}
\bibliographystyle{plainnat}
\bibliographystyleown{plainnat}
\bibliography{mybib}
\bibliographyown{mybib}
\nociteown{lim:2007,lim:latextypesetting}
\captionsetup{list=no}
\addtocontents{toc}{\protect\cftpagenumbersoff{chap}}
\titlespacing*{\chapter}{0pt}{\dimexpr2.5cm-50pt}{\baselineskip}
\titlespacing*{\chapter}{0pt}{-50pt}{\baselineskip}
```
