---
title: BMP vs CMP Relationships Compared
type: comparison
tags: [dev, ejb]
created: 2026-04-28
updated: 2026-04-28
---

## The Comparison

This synthesis compares how BMP (Bean-Managed Persistence) and CMP (Container-Managed Persistence) handle entity bean relationships (1:1, 1:N, M:N) and directionality.

## Relationship Implementation Comparison

| Aspect | BMP (Bean-Managed) | CMP (Container-Managed) |
|---|---|---|
| **Persistent Fields** | Concrete instance variables | Abstract getters/setters, no fields |
| **1:1 Relationship** | Manual JNDI lookup + `findByPrimaryKey()` in `ejbLoad()`; `getPrimaryKey()` in `ejbStore()` | `<cmr-field>` in deployment descriptor; container manages |
| **1:N Relationship** | `Vector` + JNDI lookup of other bean's Home in `ejbLoad()` | `Collection` CMR field + `<multiplicity>Many</multiplicity>` |
| **M:N Relationship** | Two 1:N relationships via junction table; manual JDBC | Two `Collection` CMR fields, both with `<multiplicity>Many</multiplicity>` |
| **Directionality** | Code both get/set methods (bidirectional) or omit one side (unidirectional) | Add/remove `<cmr-field>` entries in deployment descriptor |
| **ejbLoad/ejbStore** | Contains JNDI lookups, SQL, FK↔stub conversion | Empty — container handles everything |
| **Deployment Descriptor** | Standard EJB declaration | Additional `<relationships>` section with `<ejb-relation>` entries |
| **Code Complexity** | High — lots of boilerplate | Low — just abstract methods + XML |

## Cardinality Handling

### One-to-One (1:1)
- **BMP:** `OrderBean` holds `Shipment` stub. In `ejbLoad()`: JNDI lookup `ShipmentHome`, call `findByPrimaryKey(shipmentFK)`. In `ejbStore()`: `shipment.getPrimaryKey()` to get FK for SQL UPDATE.
- **CMP:** `public abstract Shipment getShipment()`. XML: `<cmr-field><cmr-field-name>shipment</cmr-field-name></cmr-field>`. Container does the rest.

### One-to-Many (1:N)
- **BMP:** "One" side holds `Vector` of stubs. `ejbLoad()` does JNDI lookup of "many" side Home, calls `findByXxx(oneSidePK)`.
- **CMP:** "One" side: `public abstract Collection getChildren()`. XML: `<multiplicity>Many</multiplicity>` on "many" side.

### Many-to-Many (M:N)
- **BMP:** Both sides hold `Vector` of other's stubs. Each does JNDI lookup of the other's Home with finder based on own PK. Junction table managed manually.
- **CMP:** Both sides: `public abstract Collection getOtherSide()`. Both sides in XML: `<multiplicity>Many</multiplicity>`. Container creates and manages junction table.

## Directionality Comparison

| Direction | BMP | CMP |
|---|---|---|
| **Bidirectional** | Both beans have get/set for each other | Both beans have `<cmr-field>` in descriptor |
| **Unidirectional** | One bean lacks get/set for the other | One bean lacks `<cmr-field>` in descriptor |

## Key Insights

1. **CMP reduces code dramatically:** What takes 50+ lines of JNDI/SQL in BMP takes 2-3 lines of abstract methods + a few XML tags in CMP.
2. **BMP gives control:** You can optimize SQL, add custom logic in relationship loading. CMP delegates everything to container.
3. **CMP requires deployment descriptor expertise:** Relationships are defined in XML, not Java code — harder to debug.
4. **FK↔stub conversion is the core BMP pain:** Every `ejbLoad`/`ejbStore` must convert between database foreign keys and EJB object stubs.
5. **Directionality is independent of cardinality:** Both 1:1, 1:N, and M:N can be bidirectional or unidirectional in either BMP or CMP.

## Connections
- [[bean-managed-persistence|BMP]] — manual relationship implementation
- [[container-managed-persistence|CMP]] — automatic relationship management via CMR
- [[one-to-one-relationship|One-to-One Relationship]] — 1:1 cardinality
- [[one-to-many-relationship|One-to-Many Relationship]] — 1:N cardinality
- [[many-to-many-relationship|Many-to-Many Relationship]] — M:N cardinality
- [[bidirectional-vs-unidirectional|Bidirectional vs Unidirectional]] — directionality concept
- [[cmp-abstract-accessors|CMP Abstract Accessors]] — CMP's method declarations
- [[ejb-ql|EJB-QL]] — CMP uses EJB-QL for relationship queries

## Sources
- [[EJb4-summary|EJb4.md Source Summary]]
