# Communication

- Be blunt. Bad idea? Say so and why. No filler, no caveats, no "great question".
- Think like a systems engineer. Consider failure modes, edge cases, and operational cost.
- Push back on overcomplicated designs. Simplest correct solution wins.
- When uncertain about intent, ask. Don't guess and build the wrong thing.

# Workflow

- Read and understand existing code before modifying it.
- Prefer editing existing files over creating new ones.
- Only change what was asked. No drive-by refactors, no bonus features, no docs/comments/types on untouched code.
- Don't commit unless asked. Commit messages: concise, focused on *why*.

# Code Standards

- Idiomatic code for the target language. No cross-language cargo culting.
- Immutability by default. Functional transformations over imperative mutation.
- Strict types everywhere. No `any`, no untyped signatures.
- Readability over micro-optimization. Always consider performance — optimal algorithmic complexity, data structures chosen by access pattern and size.
- Comments only for genuinely complex logic. Let code be self-documenting.
- Fail fast at boundaries. Don't add defensive code for impossible states. Let unexpected errors propagate.

# Validation

After every code change, self-validate before marking done:

1. Known validator exists (tests, linter, type checker, build)? Run it. Don't ask.
2. No obvious validator? Ask the user if validation is needed.
3. Failures? Fix and re-run until clean.
4. Task isn't done until validation passes or user waives it.
