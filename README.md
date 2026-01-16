# ABAP Object-Oriented Report Example

This repository contains a production-style ABAP report that retrieves flight and booking data and renders it in an ALV grid, structured with local classes and includes so data access, screen input, and presentation stay separated. It reflects how OO design is applied in classic SAP reporting to keep enterprise code maintainable without changing standard behavior.

## What this repository demonstrates
- OO design principles applied in ABAP report programs
- Encapsulation and separation of concerns across report includes
- Maintainable class design with focused responsibilities
- Realistic enterprise-style data retrieval and ALV output

## How to run
1) Create report `ZREPORTE1` with includes `zreporte1_gd`, `zreporte1_sel`, `zreporte1_cd`, `zreporte1_ci`.
2) Activate and execute from SE38/SA38 (or ADT).
3) Provide a valid carrier name in `p_name` (for demo data, try `Lufthansa`).

Example input:
```
p_name = Lufthansa
```