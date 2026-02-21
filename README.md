# The Evolution of Web Architecture: A Comparative Study

This repository contains the exact same Human Resources CRUD application implemented **four different times** using progressively modern architectural approaches. 

The goal of this project is not just to build a CRUD app, but to demonstrate a deep understanding of how web architecture evolved, the specific engineering bottlenecks each era faced, and how subsequent frameworks solved them.

---

## Architectural Comparison

| Stage | Pattern | What changes | Why it matters |
| :--- | :--- | :--- | :--- |
| **[01](./stage-1-servlet/)** | Imperative Servlet | HTML is manually generated via `PrintWriter` | Demonstrates raw HTTP lifecycle and the pain of hardcoded server-side rendering. |
| **[02](./stage-2-jsp-mvc/)** | MVC (JSP + Custom Tags) | UI view is separated from business logic | Shows strict separation of concerns and declarative security. |
| **[03](./stage-3-ajax-json/)** | AJAX + JSON | UI rendered in browser, server returns raw data | Proves understanding of stateless client-server models and DOM manipulation. |
| **[04](./stage-4-springboot/)** | Spring Boot SPA | Framework handles routing, ORM, and RBAC security | Demonstrates modern, production-ready Decoupled Architecture. |

---

## Consistent Design, Evolving Engine

![UI Screenshot](docs/ui-screenshot.png)

The core aesthetic, database schema, and business rules remain consistent across all four stages to provide a clear baseline for comparison. 

However, how the UI is generated and controlled evolves drastically:
* **Stages 1-3:** The UI is statically rendered, assuming a single level of administrative access.
* **Stage 4:** The UI becomes **Dynamic and Context-Aware**. It introduces Role-Based Access Control (RBAC), allowing the frontend Single Page Application (SPA) to physically alter the DOM—hiding action toolbars and mutating data tables based on whether the authenticated session belongs to an `ADMIN` or a standard `USER`.

### Stage 4: RBAC in Action (Dynamic UI)
| Admin View (Full Access) |  Standard User View (Read-Only) |
| :---: | :---: |
| ![Admin View](docs/admin-view.png) | ![User View](docs/user-view.png) |

The primary focus of this repository is tracking this evolution: how data flows from the database to the browser, how security shifts from the server to the client, and how the codebase scales.

---

## The Evolution of Security & State

A major focus of this comparative study is how authentication and session state are handled as the architecture matures.

* **Stage 1 (No Security):** The application is completely open. There is no login, no session tracking, and anyone who knows the URL can modify the database. It represents a naive, internal-only tool.
* **Stages 2 & 3 (Manual Session Management):** Authentication is introduced. The application manually validates users against the database and stores their state using standard Servlet `HttpSession` attributes. Custom Gatekeeper JSPs (Stage 2) and AJAX interceptors (Stage 3) manually check this session before allowing access.
* **Stage 4 (Enterprise Framework Security):** Security is delegated to **Spring Security**. Authentication is handled via an encrypted, HttpOnly `JSESSIONID` cookie. The application upgrades from simple "Logged In vs. Logged Out" to full **Role-Based Access Control (RBAC)**, protecting individual REST endpoints and dynamically altering the SPA UI based on the user's authority.

---

## Purpose
Built as a portfolio piece to demonstrate system design thinking, refactoring skills, and mastery of both legacy Java EE and modern Spring ecosystem paradigms.