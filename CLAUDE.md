# Thesis project instructions

## Mission

Help complete this thesis quickly without inventing facts, references, results, or
formatting rules. Prefer small, reviewable edits and preserve the author's meaning.

## Non-negotiable USM template protection

- Never edit `usmthesis.cls`. It is the official USM formatting class.
- Never edit generated files under `build/`, LaTeX auxiliary files, `.bak` files,
  or files under `extra md files/` that belong to the supplied template.
- Treat the formatting portions of `usmthesis.tex` as read-only. Only change
  thesis metadata, explicitly requested content, active chapter inputs, or
  bibliography settings when the user asks for that specific change.
- Do not change document-class options, margins, spacing, fonts, page layout,
  cover/title-page structure, list structure, or template commands unless the
  user explicitly authorizes a USM-compliance change.
- Do not normalize or reformat unrelated LaTeX while editing nearby content.
- Before a requested change would touch a protected file or template formatting,
  stop and ask for confirmation rather than guessing.

## Evidence and anti-hallucination rules

- Treat user-provided files, measured project results, and verified sources as
  authoritative. Do not fill gaps with plausible-sounding text.
- Never invent a citation, DOI, author, quotation, page number, statistic,
  experiment, result, or technical capability.
- Use the Consensus MCP server for literature discovery and claim checking when
  an external scholarly source is needed. Prefer peer-reviewed sources and
  record title, authors, year, venue, DOI, and URL before adding a reference.
- A Consensus result is evidence to inspect, not permission to overstate a claim.
  Match each sentence to the paper's actual evidence and preserve limitations.
- If a claim cannot be verified, say so and leave a clearly marked `TODO` for
  the author. Do not silently downgrade an uncertain claim into a fact.
- Do not add a bibliography entry unless the source is real and the citation key
  is used intentionally. Do not cite a paper that has not been checked.

## Writing and editing behavior

- For writing, paraphrasing, or polishing, preserve technical meaning, numbers,
  scope, certainty, citations, and the author's intended argument.
- Do not change experimental data, tables, figures, conclusions, or research
  questions unless explicitly instructed.
- Keep the thesis voice formal, precise, and appropriately cautious. Avoid
  generic filler and unsupported novelty claims.
- For substantial edits, first identify the target file/section and summarize
  the intended change; then edit only that scope.
- Use existing terminology and notation consistently across chapters.
- Keep citation keys exactly identical between `.tex` files and `mybib.bib`.
- Never edit `build/` or generated `.bbl` files to solve a citation problem.

## Repository workflow

- Main content lives in `chapters/`, with project metadata and document wiring
  in `usmthesis.tex` and `mainchaps.tex`.
- Use `mybib.bib` for active references. The citation checker follows active
  `\input`/`\include` files from `usmthesis.tex`.
- After changing citations or LaTeX content, run:

  ```powershell
  powershell -ExecutionPolicy Bypass -File scripts\build-thesis.ps1
  ```

- Inspect the build output for errors, undefined references, missing citations,
  overfull boxes, and unexpected layout changes. Report failures explicitly.
- Before finishing, inspect `git diff --check` and `git diff`; confirm that only
  requested source files changed and that protected files are unchanged.
- Do not commit, push, delete files, or rewrite history unless the user asks.

## Efficient task protocol

1. Read the relevant section and its nearby context before editing.
2. State assumptions and identify any claims requiring external evidence.
3. Use Consensus only for targeted searches; do not perform broad, repetitive
   searches when the local thesis sources already answer the question.
4. Make the smallest coherent edit.
5. Run the smallest relevant validation, then the thesis build when LaTeX or
   citations changed.
6. Report changed files, evidence used, validation results, and unresolved TODOs.

