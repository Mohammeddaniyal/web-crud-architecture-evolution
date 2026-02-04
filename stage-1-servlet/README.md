# Stage 1:  Imperative Servlet (Server-Side HTML)

## What this stage demonstrates

This version shows how a web application works when the server is responsible for generating the entire HTML response using `PrintWriter`.

There is no separation between UI rendering and business logic. The servlet handles request processing, database interaction, and HTML generation in the same place.

---

## Data Flow

```
Request:  Browser → Servlet → DAO → Database
Response: Browser ← HTML (generated using PrintWriter) ← Servlet
```

---

## Limitation of this approach

* UI and logic are tightly coupled
* HTML is constructed manually inside Java code
* Difficult to maintain and scale
* Any UI change requires modifying servlet code

---

## Key Takeaway

Understanding this stage is essential to appreciate why MVC frameworks and view technologies were introduced later.

---

## Next Stage

[Stage 2 — JSP MVC](../stage-2-jsp-mvc/)

