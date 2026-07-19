---
name: define-quality-attributes
description: >
  Transforma necesidades de producto, negocio, usuarios y operación en
  atributos de calidad explícitos, medibles, priorizados y verificables antes
  de diseñar la arquitectura. Define escenarios con métricas y umbrales para
  seguridad, disponibilidad, rendimiento, consistencia, operabilidad y otros
  atributos, sin seleccionar stack ni diseñar componentes definitivos. Úsala
  cuando el alcance del incremento esté definido y se necesiten drivers
  arquitectónicos o trade-offs no funcionales. Produce
  docs/architecture/quality-attributes.md y un gate (QUALITY ATTRIBUTES READY,
  CONDITIONALLY READY, MEASUREMENT REQUIRED, REFINEMENT REQUIRED, SPECIALIST
  REVIEW REQUIRED, BLOCKED).
---

# define-quality-attributes

## Propósito

Transformar necesidades de producto, negocio, usuarios y operación en atributos de calidad explícitos, medibles, priorizados y verificables antes de diseñar la arquitectura.

Esta skill define qué tan seguro, disponible, rápido, consistente, mantenible, observable, accesible, interoperable, operable y eficiente debe ser el sistema, bajo condiciones concretas.

Su resultado debe permitir que decisiones arquitectónicas posteriores respondan a necesidades demostrables y no a preferencias, modas o optimizaciones especulativas.

---

## Compatibilidad

Esta skill es agnóstica al modelo, proveedor, lenguaje, framework y plataforma.

Puede utilizarse con Codex, OpenCode, Claude Code, Grok, Kimi, DeepSeek o cualquier agente capaz de inspeccionar documentación y repositorios.

La fuente de verdad es el repositorio.

---

## Cuándo utilizarla

Utilizar esta skill cuando:

* el alcance del producto o próximo incremento esté definido;
* existan features suficientemente diseñadas;
* se necesiten criterios para evaluar arquitectura;
* el sistema tenga requisitos de seguridad, disponibilidad, rendimiento, cumplimiento o escala;
* un proyecto existente deba revisar sus necesidades no funcionales;
* existan conflictos entre velocidad, coste, resiliencia, consistencia o mantenibilidad;
* se esté por realizar un spike o revisión arquitectónica.

No utilizarla para:

* seleccionar tecnologías;
* diseñar componentes definitivos;
* decidir microservicios, colas, cache o proveedores;
* inventar objetivos sin evidencia;
* convertir todas las cualidades deseables en requisitos críticos.

---

## Entradas esperadas

Revisar, cuando existan:

* `AGENTS.md`;
* `docs/project-status.md`;
* `docs/product/scope.md`;
* documentación de descubrimiento y validación;
* especificaciones de features;
* auditoría del proyecto existente;
* arquitectura actual;
* métricas de producción;
* incidentes;
* acuerdos comerciales;
* restricciones legales;
* necesidades operativas;
* perfiles de usuarios;
* previsiones de crecimiento;
* límites de presupuesto;
* dependencias externas.

Clasificar cada entrada como:

* evidencia observada;
* requisito contractual;
* restricción;
* decisión;
* supuesto;
* estimación;
* preferencia;
* desconocido.

---

## Entregables

Crear o actualizar:

```text
docs/architecture/quality-attributes.md
```

Opcionalmente:

```text
docs/architecture/quality-budget.md
docs/architecture/quality-risks.md
```

Actualizar `docs/project-status.md` con:

* gate;
* atributos críticos;
* riesgos;
* bloqueantes;
* siguiente skill recomendada.

No duplicar documentación existente. Enlazar fuentes canónicas.

---

## Principios

### Utilizar escenarios, no adjetivos

Evitar requisitos como:

* “el sistema debe ser rápido”;
* “debe ser seguro”;
* “debe escalar”;
* “debe tener alta disponibilidad”.

Cada atributo debe expresarse mediante condiciones, carga, respuesta, métricas y umbrales verificables.

### Priorizar

No todos los atributos pueden maximizarse simultáneamente.

Clasificar cada requisito como:

* `CRITICAL`;
* `HIGH`;
* `MEDIUM`;
* `LOW`;
* `DEFERRED`;
* `NOT REQUIRED`.

Un atributo no es crítico solo porque sea deseable.

### Evitar optimización especulativa

Todo umbral debe derivarse de:

* comportamiento de usuarios;
* impacto de negocio;
* regulación;
* contrato;
* evidencia operacional;
* dependencia externa;
* riesgo explícitamente aceptado.

Cuando no exista evidencia suficiente, registrar una hipótesis, rango provisional o necesidad de medición.

---

## Quality-Attribute Scenario

Registrar cada escenario con identificador estable:

```text
QA-SEC-001
```

Cada escenario debe incluir:

* atributo;
* fuente del estímulo;
* estímulo;
* contexto o condición;
* componente o capacidad afectada;
* respuesta esperada;
* métrica;
* umbral objetivo;
* umbral mínimo aceptable;
* carga o volumen;
* criticidad;
* evidencia;
* método de verificación;
* owner;
* riesgo si no se cumple;
* estado;
* fecha o condición de revisión.

Formato conceptual:

```text
Given:
When:
Then:
Measured by:
Target:
Minimum acceptable:
Verification:
```

---

## Procedimiento

## 1. Establecer contexto

Definir:

* producto o sistema analizado;
* horizonte temporal;
* incremento relevante;
* usuarios;
* procesos críticos;
* flujos de negocio prioritarios;
* datos sensibles;
* dependencias esenciales;
* volumen actual;
* crecimiento esperado;
* restricciones;
* consecuencias de fallo.

Distinguir entre:

* necesidades de todo el sistema;
* necesidades de una feature;
* necesidades futuras todavía no comprometidas.

---

## 2. Seguridad y privacidad

Evaluar:

* autenticación;
* autorización;
* mínimo privilegio;
* aislamiento entre cuentas o tenants;
* protección de datos;
* gestión de secretos;
* trazabilidad;
* abuso;
* fraude;
* impersonación;
* exportación;
* eliminación;
* retención;
* consentimiento;
* exposición en logs y analytics.

Definir escenarios sobre:

* accesos no autorizados;
* escalada de privilegios;
* enumeración de recursos;
* fuga de datos;
* credenciales comprometidas;
* acciones sensibles;
* contenido malicioso;
* respuesta ante incidentes.

Registrar:

* datos protegidos;
* actores autorizados;
* tiempo de detección;
* tiempo de contención;
* evidencia requerida;
* riesgo residual.

Los requisitos críticos deben remitirse posteriormente a `review-security`.

---

## 3. Disponibilidad, resiliencia y recuperación

Identificar funciones y dependencias críticas.

Definir:

* horario de servicio;
* disponibilidad objetivo;
* degradación aceptable;
* tolerancia a fallos;
* tiempo máximo de interrupción;
* pérdida máxima de datos;
* recuperación;
* reintentos;
* idempotencia;
* operación parcial;
* continuidad manual.

Cuando corresponda, establecer:

* `RTO`: tiempo objetivo de recuperación;
* `RPO`: pérdida máxima de datos aceptable;
* error budget;
* frecuencia de backups;
* verificación de restauración.

Diferenciar entre:

* caída total;
* degradación;
* dependencia externa caída;
* procesamiento retrasado;
* datos temporalmente desactualizados.

No exigir alta disponibilidad sin justificar impacto y coste.

---

## 4. Rendimiento, latencia y capacidad

Identificar journeys y operaciones sensibles al tiempo.

Para cada escenario definir:

* operación;
* carga concurrente;
* volumen de datos;
* percentil relevante;
* latencia objetivo;
* timeout;
* throughput;
* duración máxima de procesos;
* comportamiento bajo saturación.

Preferir percentiles como `p95` o `p99` cuando sean relevantes, no solo promedios.

Distinguir:

* interacción humana;
* procesos en segundo plano;
* búsquedas;
* importaciones;
* exportaciones;
* operaciones masivas;
* integraciones.

Definir cómo se medirá y con qué datos representativos.

---

## 5. Escalabilidad

Determinar qué dimensión puede crecer:

* usuarios;
* tenants;
* datos;
* tráfico;
* archivos;
* eventos;
* integraciones;
* regiones;
* tareas asíncronas;
* operaciones administrativas.

Registrar:

* baseline;
* volumen esperado;
* horizonte;
* pico;
* patrón de crecimiento;
* límite aceptable;
* señal de saturación;
* estrategia de verificación.

No diseñar para una escala hipotética sin probabilidad o impacto significativo.

Separar:

* capacidad necesaria ahora;
* capacidad prevista;
* capacidad que solo requiere no cerrar opciones futuras.

---

## 6. Consistencia e integridad de datos

Definir para cada dato o proceso crítico:

* fuente de verdad;
* invariantes;
* unicidad;
* atomicidad requerida;
* consistencia esperada;
* tolerancia a datos desactualizados;
* orden de eventos;
* duplicados;
* concurrencia;
* reconciliación;
* historial;
* auditabilidad;
* eliminación.

Distinguir cuándo se requiere:

* consistencia inmediata;
* consistencia eventual;
* lectura de datos potencialmente obsoletos;
* compensación;
* revisión manual.

Documentar consecuencias de:

* escritura parcial;
* procesamiento duplicado;
* actualización concurrente;
* pérdida de orden;
* fallo entre sistemas.

No convertir preferencia técnica en regla de consistencia.

---

## 7. Mantenibilidad y modificabilidad

Identificar cambios previsibles:

* nuevas reglas;
* nuevos roles;
* nuevos canales;
* nuevas integraciones;
* cambios regulatorios;
* nuevos planes;
* ampliación de estados;
* sustitución de proveedores.

Para cada cambio relevante definir:

* frecuencia probable;
* alcance esperado;
* tiempo o esfuerzo aceptable;
* riesgo;
* áreas que deberían permanecer desacopladas;
* evidencia de que el cambio es probable.

Evaluar:

* claridad;
* cohesión;
* acoplamiento;
* documentación;
* ownership;
* facilidad de evolución;
* compatibilidad hacia atrás.

No exigir extensibilidad genérica para escenarios no identificados.

---

## 8. Testabilidad

Definir qué comportamientos deben poder verificarse de forma:

* determinista;
* aislada;
* automatizada;
* reproducible;
* observable.

Evaluar necesidades de:

* datos de prueba;
* ambientes;
* control del tiempo;
* simulación de dependencias;
* pruebas de fallos;
* contratos;
* permisos;
* concurrencia;
* migraciones;
* rollback.

Registrar:

* tiempo aceptable del feedback;
* estabilidad esperada;
* evidencia necesaria;
* flujos que requieren pruebas end-to-end;
* riesgos que necesitan verificación manual o especializada.

---

## 9. Observabilidad y auditabilidad

Definir qué preguntas operativas deben poder responderse:

* ¿El sistema funciona?
* ¿Dónde falla?
* ¿A quién afecta?
* ¿Qué cambió?
* ¿Qué acción realizó un actor?
* ¿Puede reconstruirse un incidente?

Cubrir:

* logs;
* métricas;
* trazas;
* alertas;
* eventos de negocio;
* correlación;
* auditoría;
* retención;
* privacidad;
* acceso a evidencia.

Para cada escenario indicar:

* señal;
* umbral;
* destinatario;
* tiempo de detección;
* acción esperada;
* información prohibida.

Distinguir observabilidad técnica, analytics y auditoría.

---

## 10. Accesibilidad y compatibilidad

Definir requisitos verificables sobre:

* navegación por teclado;
* foco;
* semántica;
* lectores de pantalla;
* contraste;
* zoom;
* reducción de movimiento;
* mensajes de error;
* objetivos táctiles;
* contenido alternativo;
* responsive.

Definir compatibilidad con:

* navegadores;
* dispositivos;
* tamaños de pantalla;
* sistemas operativos;
* idiomas;
* zonas horarias;
* tecnologías asistivas;
* versiones de contratos públicos.

No utilizar “compatible con todo”. Delimitar soporte y degradación aceptable.

---

## 11. Interoperabilidad y portabilidad

Identificar:

* sistemas externos;
* formatos de intercambio;
* consumidores;
* contratos;
* importaciones;
* exportaciones;
* proveedores sustituibles;
* restricciones de alojamiento o región.

Definir:

* compatibilidad;
* versionado;
* tolerancia a cambios;
* idempotencia;
* límites;
* portabilidad de datos;
* procedimiento de salida;
* dependencia aceptable del proveedor.

No exigir independencia total de proveedores sin justificar coste y riesgo.

---

## 12. Operabilidad y soporte

Definir necesidades para:

* despliegue;
* configuración;
* diagnóstico;
* corrección manual;
* reintentos;
* moderación;
* soporte;
* restauración;
* rollback;
* administración;
* incidentes.

Para operaciones críticas establecer:

* owner;
* permisos;
* procedimiento;
* tiempo objetivo;
* evidencia;
* riesgo;
* escalamiento.

Identificar procesos que pueden permanecer manuales y su capacidad máxima aceptable.

---

## 13. Costos y eficiencia

Definir presupuestos o límites sobre:

* infraestructura;
* servicios externos;
* almacenamiento;
* transferencia;
* observabilidad;
* soporte;
* procesamiento;
* coste por usuario, tenant u operación.

Relacionar cada límite con:

* modelo de negocio;
* volumen;
* margen;
* criticidad;
* incertidumbre.

Distinguir:

* coste fijo;
* coste variable;
* coste de picos;
* coste operacional;
* coste de complejidad.

No optimizar costes sacrificando atributos críticos sin decisión explícita.

---

## 14. Cumplimiento

Identificar obligaciones:

* legales;
* regulatorias;
* contractuales;
* fiscales;
* de privacidad;
* de accesibilidad;
* de retención;
* de residencia de datos;
* de auditoría.

Para cada obligación registrar:

* fuente;
* jurisdicción;
* alcance;
* owner;
* evidencia requerida;
* frecuencia;
* consecuencia de incumplimiento;
* necesidad de revisión profesional.

El agente no debe inventar interpretación legal definitiva.

---

## 15. Developer experience

Definir necesidades de:

* setup reproducible;
* documentación;
* feedback local;
* comandos deterministas;
* ambientes;
* datos de prueba;
* debugging;
* CI;
* actualización de contratos;
* onboarding;
* recuperación ante errores.

Establecer métricas cuando sean relevantes:

* tiempo de setup;
* tiempo de feedback;
* frecuencia de fallos;
* reproducibilidad;
* complejidad operativa.

Developer experience no debe priorizarse sobre seguridad o integridad, pero sí considerarse como atributo de sostenibilidad.

---

## 16. Trade-offs y conflictos

Crear una matriz de conflictos, por ejemplo:

* seguridad frente a facilidad de uso;
* consistencia frente a disponibilidad;
* latencia frente a coste;
* resiliencia frente a complejidad;
* portabilidad frente a aprovechamiento del proveedor;
* observabilidad frente a privacidad;
* velocidad de entrega frente a modificabilidad;
* accesibilidad frente a restricciones visuales.

Para cada conflicto indicar:

* atributos enfrentados;
* escenario;
* decisión recomendada;
* evidencia;
* consecuencias;
* riesgo residual;
* autoridad necesaria.

No ocultar trade-offs bajo afirmaciones de que “todo es prioritario”.

---

## Quality budgets

Cuando aplique, crear presupuestos explícitos:

* latency budget;
* availability/error budget;
* recovery budget;
* capacity budget;
* cost budget;
* data-loss budget;
* operational workload budget;
* complexity budget.

Cada presupuesto debe tener:

* alcance;
* unidad;
* límite;
* periodo;
* owner;
* método de medición;
* respuesta ante agotamiento.

---

## Priorización

Evaluar cada escenario según:

* impacto;
* probabilidad;
* frecuencia;
* criticidad del flujo;
* regulación;
* coste del incumplimiento;
* evidencia;
* reversibilidad;
* coste de implementación.

Separar:

* arquitectura-driving requirements;
* requisitos locales de una feature;
* preferencias;
* optimizaciones futuras;
* unknowns.

Solo los requisitos que condicionan significativamente la estructura del sistema deben impulsar decisiones arquitectónicas globales.

---

## Revisión adversarial

Preguntar:

* ¿El umbral tiene evidencia?
* ¿La carga es realista?
* ¿La métrica puede medirse?
* ¿El método de verificación es reproducible?
* ¿Se está optimizando para un futuro improbable?
* ¿Se ignora un flujo crítico?
* ¿Dos atributos se contradicen?
* ¿El coste es proporcional al riesgo?
* ¿Existe owner?
* ¿La condición de fallo está definida?
* ¿Un requisito local está forzando arquitectura global?
* ¿Se puede aplazar sin cerrar opciones?
* ¿Falta aprobación humana?

Registrar contradicciones, unknowns y decisiones pendientes.

---

## Gates

### QUALITY ATTRIBUTES READY

Los atributos críticos están priorizados, medidos, trazables y verificables.

Puede continuar a `review-architecture` o al diseño arquitectónico correspondiente.

### CONDITIONALLY READY

Puede avanzarse con:

* umbrales provisionales;
* supuestos explícitos;
* riesgos aceptados;
* mediciones pendientes no bloqueantes.

Cada condición debe tener owner y criterio de resolución.

### MEASUREMENT REQUIRED

Falta una baseline o evidencia necesaria para definir umbrales confiables.

Debe realizarse medición, benchmark, prueba o spike.

### REFINEMENT REQUIRED

Existen requisitos vagos, contradictorios, no verificables o sin prioridad.

### SPECIALIST REVIEW REQUIRED

Se requiere revisión especializada legal, de seguridad, privacidad, accesibilidad, cumplimiento u otra disciplina.

### BLOCKED

Faltan decisiones, restricciones, evidencia o autoridad indispensables para diseñar arquitectura responsablemente.

---

## Checklist final

Antes de cerrar verificar:

* [ ] Cada atributo crítico tiene escenarios concretos.
* [ ] Existen métricas y umbrales.
* [ ] Se documentaron carga y condiciones.
* [ ] Cada escenario tiene criticidad y evidencia.
* [ ] Existe método de verificación.
* [ ] Existe owner.
* [ ] Se identificaron riesgos.
* [ ] Se distinguieron requisitos de especulación.
* [ ] Se definieron quality budgets aplicables.
* [ ] Se analizaron trade-offs.
* [ ] Se identificaron architecture drivers.
* [ ] Se registraron aprobaciones humanas.
* [ ] El gate es coherente con los unknowns.

---

## Prohibiciones

Esta skill no debe:

* seleccionar tecnologías;
* diseñar arquitectura definitiva;
* prescribir microservicios, cache, colas o replicación;
* inventar métricas;
* exigir máxima calidad en todos los atributos;
* ocultar incertidumbre;
* confundir optimización futura con requisito actual;
* ignorar costes;
* aceptar requisitos no verificables;
* reemplazar revisión legal o especializada;
* aprobar decisiones irreversibles sin autoridad humana.

---

## Formato recomendado

```markdown
# Quality Attributes

## Context
## Sources and Evidence
## Critical Business Flows
## Assumptions and Unknowns
## Architecture-Driving Requirements
## Quality-Attribute Scenarios
### Security and Privacy
### Availability, Resilience and Recovery
### Performance and Capacity
### Scalability
### Data Consistency and Integrity
### Maintainability and Modifiability
### Testability
### Observability and Auditability
### Accessibility and Compatibility
### Interoperability and Portability
### Operability and Support
### Costs and Efficiency
### Compliance
### Developer Experience
## Quality Budgets
## Trade-offs
## Risks
## Required Measurements or Spikes
## Human Approvals
## Final Gate
```

---

## Informe final

Informar:

* gate obtenido;
* atributos críticos;
* architecture drivers;
* escenarios definidos;
* presupuestos establecidos;
* principales trade-offs;
* riesgos críticos;
* mediciones pendientes;
* aprobaciones humanas;
* siguiente skill recomendada.

La siguiente skill normalmente será:

* `review-architecture`;
* un spike técnico o benchmark;
* `review-security`;
* revisión especializada;
* refinamiento de producto o feature si las necesidades siguen siendo ambiguas.
