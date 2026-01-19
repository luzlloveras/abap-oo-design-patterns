# ABAP Object-Oriented Design Patterns

This repository demonstrates how object-oriented design patterns are applied in ABAP to solve realistic enterprise backend problems.

The main focus is a Supplier Approval Flow that models validation, decision-making, and state transitions using well-known OO patterns such as Factory and Strategy. The goal is to show how these patterns improve maintainability, extensibility, and separation of concerns in real ABAP applications.

---

## Example Use Case: Supplier Approval Flow

The Supplier Approval Flow represents a common enterprise backend scenario where supplier data must be validated and approved before becoming active.

This example demonstrates:
- Selection of validation behavior using the Strategy pattern
- Controlled object creation through a Factory
- Clear separation between orchestration logic and domain rules
- Deterministic handling of valid and invalid state transitions

The flow is implemented end-to-end using ABAP Objects, without external dependencies.

---

## Design Patterns Applied

The repository focuses on applying patterns with a clear purpose, not as isolated examples.

Patterns used include:
- **Factory** for encapsulating object creation based on context
- **Strategy** for switching validation logic at runtime
- **Interfaces** to decouple orchestration from concrete implementations

Each pattern is applied to solve a concrete problem in the approval flow.

---

## Testing

The Supplier Approval Flow is covered with **ABAP Unit tests** to validate:
- Valid approval scenarios
- Invalid transitions and error handling
- Correct strategy selection

Tests are isolated and do not rely on external systems.

---

## Usage Snippets

Short usage examples show how the approval flow is consumed from ABAP code.

The snippets demonstrate instantiation of the approval flow, execution of validations, and handling of success and error results. They are located in the `docs/usage_snippets.abap` file.
