# ABAP OO Design Patterns for a Backend Flow

This repository shows ABAP OO design patterns applied to a realistic backend flow. It focuses on small, composable classes with clear responsibilities, illustrating how classic ABAP can be structured for maintainability without changing standard behavior.

## What this repository demonstrates
- OO design principles applied in ABAP backend flows
- Encapsulation and separation of concerns
- Maintainable class design with focused responsibilities
- Enterprise-style flow orchestration without external dependencies

## Supplier Approval Flow
The main example models a supplier onboarding decision flow with explicit input, strategy selection, and a clear success/error result. A factory resolves the validation strategy based on status, and the flow returns the next status when validation succeeds. The orchestration stays in one place, while strategies remain small and focused. See `zsupplier_approval_flow.abap` for the implementation.

## Tests
Run ABAP Unit for `zsupplier_approval_flow` from ADT or SE38.
Tests require access to an ABAP system.

## Usage snippets
- `docs/usage_snippets.abap`

## Additional report example (ALV)
ZREPORTE1 remains in the repository as a classic ALV report with separated includes for declarations, selection, and implementation. It is included as an additional example alongside the main flow.

How to run:
1) Create report `ZREPORTE1` with includes `zreporte1_gd`, `zreporte1_sel`, `zreporte1_cd`, `zreporte1_ci`.
2) Activate and execute from SE38/SA38 (or ADT).
3) Provide a valid carrier name in `p_name` (for demo data, try `Lufthansa`).
