# review-feature

## Propósito

Revisar adversarialmente una feature ya diseñada antes de planificar o implementar.

Esta skill evalúa si la especificación es coherente, valiosa, completa, segura, verificable y suficientemente delimitada. Su objetivo no es confirmar el trabajo previo, sino intentar encontrar:

* contradicciones;
* ambigüedades;
* supuestos ocultos;
* riesgos no tratados;
* permisos incorrectos;
* flujos incompletos;
* scope creep;
* criterios imposibles de verificar;
* decisiones faltantes;
* dificultades para implementar la feature como vertical slices.

La revisión debe producir evidencia y decisiones explícitas, no una opinión general.

---

## Compatibilidad

Esta skill es agnóstica al modelo, proveedor, lenguaje y stack tecnológico.

Puede utilizarse con Codex, OpenCode, Claude Code, Grok, Kimi, DeepSeek o cualquier agente capaz de inspeccionar documentación y repositorios.

La fuente de verdad es el repositorio. El historial del chat puede aportar contexto, pero no debe reemplazar la documentación estable.

Idealmente, la revisión debe realizarla un agente o una sesión distinta de quien diseñó la feature.

---

## Cuándo utilizarla

Utilizar esta skill cuando:

* exista una especificación creada mediante `design-feature`;
* una feature vaya a pasar a planificación;
* cambie su alcance, comportamiento, permisos o modelo de datos;
* existan múltiples interpretaciones posibles;
* afecte autenticación, billing, datos sensibles, ownership o integraciones;
* una feature existente deba ampliarse;
* se necesite una revisión independiente antes de aprobarla.

No utilizarla para:

* implementar;
* corregir código;
* seleccionar tecnologías;
* sustituir descubrimiento o validación;
* rediseñar silenciosamente la feature;
* aprobar automáticamente el diseño anterior.

---

## Entradas esperadas

Revisar, cuando existan:

* `AGENTS.md`;
* `docs/project-status.md`;
* `docs/product/scope.md`;
* `docs/features/<feature-name>/spec.md`;
* `docs/features/<feature-name>/test-plan.md`;
* `docs/features/<feature-name>/open-questions.md`;
* validaciones de supuestos;
* arquitectura de información;
* atributos de calidad;
* decisiones registradas;
* features relacionadas;
* contratos existentes;
* comportamiento actual del sistema;
* requisitos legales, comerciales y operativos.

Si falta una entrada relevante, registrarlo como limitación de la revisión.

---

## Entregables

Crear:

```text
docs/features/<feature-name>/review.md
```

El archivo debe contener:

1. alcance de la revisión;
2. fuentes examinadas;
3. resumen ejecutivo;
4. hallazgos;
5. contradicciones;
6. ambigüedades;
7. riesgos;
8. decisiones faltantes;
9. condiciones de aprobación;
10. gate final.

No modificar silenciosamente `spec.md`.

Las correcciones propuestas deben registrarse como recomendaciones. La especificación solamente debe cambiarse cuando exista autorización para hacerlo.

Actualizar `docs/project-status.md` si cambia el gate, aparecen bloqueantes o se modifica la próxima acción recomendada.

---

## Clasificación de hallazgos

Asignar a cada hallazgo:

### Severidad

* `CRITICAL`: puede producir daño grave, violación de seguridad, pérdida de datos, incumplimiento o comportamiento fundamentalmente incorrecto.
* `HIGH`: impide planificar o implementar de forma confiable.
* `MEDIUM`: genera ambigüedad, deuda o riesgo relevante, pero puede resolverse durante planificación bajo una condición explícita.
* `LOW`: mejora recomendada sin impacto inmediato significativo.
* `NOTE`: observación informativa.

### Tipo

* contradicción;
* omisión;
* ambigüedad;
* scope creep;
* riesgo;
* decisión faltante;
* evidencia insuficiente;
* criterio no verificable;
* dependencia;
* inconsistencia documental.

### Estado

* abierto;
* aceptado como riesgo;
* resuelto;
* diferido;
* no aplicable.

Cada hallazgo debe incluir:

* identificador;
* ubicación;
* descripción;
* evidencia;
* impacto;
* recomendación;
* owner;
* condición de cierre.

---

## Procedimiento

## 1. Verificar trazabilidad

Confirmar que la feature puede vincularse con:

* un problema identificado;
* un usuario o actor concreto;
* un resultado esperado;
* una capacidad incluida en el alcance;
* evidencia, decisión o supuesto explícito;
* un incremento del producto.

Preguntar:

* ¿La feature resuelve el problema declarado?
* ¿El resultado depende realmente de esta feature?
* ¿Se está implementando una solución solicitada sin comprender la necesidad?
* ¿Existe una solución más simple?
* ¿La feature contradice el alcance vigente?

Bloquear cuando la feature no tenga una razón verificable para existir.

---

## 2. Revisar valor

Evaluar:

* valor para el usuario primario;
* valor para actores secundarios;
* impacto esperado para el producto o negocio;
* frecuencia y contexto de uso;
* coste operativo introducido;
* comportamiento alternativo actual;
* evidencia disponible;
* proporcionalidad entre complejidad y valor.

Distinguir:

* valor demostrado;
* valor inferido;
* valor hipotético;
* conveniencia interna;
* preferencia de stakeholder.

Una feature no debe aprobarse solo porque sea técnicamente posible.

---

## 3. Revisar alcance

Comprobar que existan:

* comportamientos dentro del alcance;
* no objetivos;
* actores cubiertos;
* actores excluidos;
* casos futuros no comprometidos;
* comportamiento existente que debe preservarse.

Buscar scope creep como:

* soporte para segmentos no priorizados;
* automatización innecesaria;
* integraciones “por si acaso”;
* configuración excesiva;
* capacidades administrativas no justificadas;
* optimizaciones prematuras;
* generalizaciones sin evidencia.

Preguntar si cada elemento incluido contribuye al resultado esperado.

No rediseñar el alcance. Registrar cualquier reducción, ampliación o división recomendada para aprobación.

---

## 4. Revisar flujos

Examinar:

* flujo principal;
* flujos alternativos;
* cancelación;
* abandono;
* recuperación;
* operaciones parciales;
* soporte;
* moderación;
* administración;
* dependencia externa;
* comportamiento asíncrono.

Para cada flujo verificar:

* precondiciones;
* actor;
* acción;
* respuesta;
* transición;
* feedback;
* postcondición;
* recuperación.

Buscar pasos donde el implementador todavía tendría que inventar comportamiento.

---

## 5. Revisar actores, ownership y permisos

Confirmar:

* quién inicia cada acción;
* quién posee cada recurso;
* quién puede verlo o modificarlo;
* a qué organización, tenant o cuenta pertenece;
* qué ocurre al cambiar ownership;
* qué sucede cuando se revoca acceso;
* cómo se aplican permisos heredados;
* qué acciones requieren privilegios especiales.

Revisar operaciones de:

* creación;
* lectura;
* listado;
* edición;
* eliminación;
* publicación;
* aprobación;
* transferencia;
* exportación;
* restauración;
* administración masiva.

Buscar:

* acceso entre tenants;
* escalada de privilegios;
* permisos implícitos;
* controles solo visuales;
* owners ambiguos;
* administradores excesivamente poderosos;
* recursos huérfanos.

---

## 6. Revisar reglas, estados y transiciones

Para cada regla de negocio comprobar:

* claridad;
* razón;
* autoridad;
* excepciones;
* momento de evaluación;
* relación con criterios de aceptación;
* consistencia con otras reglas.

Para cada ciclo de vida verificar:

* estado inicial;
* estados terminales;
* transiciones válidas;
* transiciones inválidas;
* actor autorizado;
* efectos secundarios;
* reversibilidad;
* concurrencia;
* expiración;
* automatizaciones.

Buscar:

* estados imposibles;
* dimensiones mezcladas;
* transiciones sin owner;
* acciones repetibles indebidamente;
* reglas contradictorias;
* dependencias circulares.

---

## 7. Revisar validaciones, errores y edge cases

Comprobar validaciones de:

* formato;
* negocio;
* permisos;
* contexto;
* seguridad;
* concurrencia;
* límites.

Revisar errores por:

* entrada inválida;
* recurso inexistente;
* acceso denegado;
* conflicto;
* dependencia caída;
* timeout;
* duplicado;
* estado incompatible;
* operación parcial;
* límite superado.

Verificar que cada error defina:

* mensaje;
* recuperación;
* reintento;
* preservación de datos;
* logging;
* impacto sobre el estado.

Evaluar edge cases relevantes:

* doble envío;
* múltiples pestañas;
* conexión interrumpida;
* sesión expirada;
* cambios simultáneos;
* datos históricos;
* zonas horarias;
* archivos grandes;
* recursos eliminados;
* reintentos;
* fallos parciales;
* contenido extremo;
* permisos revocados.

No exigir soporte para todos, pero sí decisiones explícitas sobre los críticos.

---

## 8. Revisar seguridad, privacidad y abuso

Evaluar:

* autenticación;
* autorización;
* aislamiento;
* exposición de datos;
* datos sensibles;
* retención;
* eliminación;
* consentimiento;
* auditoría;
* impersonación;
* exportaciones;
* contenido generado por usuarios;
* fraude;
* spam;
* automatización abusiva;
* enumeración de recursos;
* manipulación de entradas.

Preguntar:

* ¿Puede un usuario acceder a datos ajenos?
* ¿Puede inferir que un recurso privado existe?
* ¿Puede repetir una acción para obtener beneficio?
* ¿Puede evadir límites?
* ¿Se recolectan datos innecesarios?
* ¿Los logs o analytics exponen información sensible?
* ¿Existe una ruta de moderación o respuesta?

Los riesgos críticos requieren revisión especializada mediante `review-security`.

---

## 9. Revisar UX, accesibilidad y responsive

Comprobar que estén definidos:

* loading;
* empty;
* error;
* unauthorized;
* success;
* partial success;
* disabled;
* processing;
* offline, cuando aplique.

Distinguir correctamente:

* no autenticado;
* sin permiso;
* sin contenido;
* sin resultados;
* error;
* plan insuficiente.

Revisar accesibilidad:

* teclado;
* foco;
* semántica;
* mensajes;
* contraste;
* tecnologías asistivas;
* reducción de movimiento;
* preservación de datos;
* objetivos táctiles.

Revisar responsive:

* prioridades de contenido;
* acciones disponibles;
* reorganización;
* zoom;
* interacción táctil;
* pantallas pequeñas;
* contenido largo;
* conectividad limitada.

Marcar requisitos vagos como “responsive” o “accesible” cuando no sean verificables.

---

## 10. Revisar datos y contratos

Evaluar conceptos de datos:

* owner;
* fuente de verdad;
* atributos mínimos;
* sensibilidad;
* relaciones;
* ciclo de vida;
* historial;
* retención;
* eliminación;
* integridad;
* sincronización.

Revisar contratos preliminares:

* entradas;
* salidas;
* errores;
* permisos;
* idempotencia;
* consistencia;
* versionado;
* compatibilidad;
* límites;
* privacidad.

Buscar:

* duplicación sin autoridad clara;
* datos sin owner;
* contratos ambiguos;
* incompatibilidad con consumidores existentes;
* operaciones no idempotentes;
* sincronización indefinida;
* eliminación imposible;
* efectos secundarios ocultos.

No definir tablas, APIs o tecnologías definitivas durante esta revisión.

---

## 11. Revisar integraciones y dependencias

Para cada dependencia comprobar:

* necesidad;
* owner;
* estado;
* criticidad;
* disponibilidad;
* límites;
* fallos;
* alternativa;
* desacoplamiento;
* impacto operativo;
* riesgo contractual.

Evaluar qué ocurre cuando:

* la integración está caída;
* responde tarde;
* devuelve datos inconsistentes;
* procesa dos veces;
* procesa parcialmente;
* cambia su contrato;
* revoca acceso.

Las dependencias no confirmadas deben registrarse como riesgo o bloqueo.

---

## 12. Revisar métricas, operación y soporte

Comprobar que las métricas permitan responder:

* adopción;
* inicio;
* finalización;
* abandono;
* errores;
* repetición;
* resultado;
* efectos adversos.

Verificar:

* métrica principal;
* guardrails;
* baseline;
* segmentos;
* criterio de éxito;
* criterio de alerta;
* privacidad.

Evaluar operación:

* observabilidad;
* auditoría;
* soporte;
* moderación;
* correcciones manuales;
* documentación;
* capacitación;
* escalamiento de incidentes.

Preguntar quién detectará y resolverá problemas después del lanzamiento.

---

## 13. Revisar rollout y rollback

Comprobar que el rollout defina:

* usuarios iniciales;
* orden de activación;
* controles;
* señales de avance;
* señales de pausa;
* comunicación;
* soporte;
* verificación posterior.

Comprobar que el rollback indique:

* disparadores;
* autoridad;
* tiempo objetivo;
* desactivación;
* compatibilidad;
* tratamiento de datos creados;
* efectos irreversibles;
* verificación posterior.

No aceptar “revertir el deploy” como estrategia suficiente cuando existan datos, contratos o efectos externos.

---

## 14. Revisar aceptación y testing

Cada criterio de aceptación debe ser:

* observable;
* inequívoco;
* trazable;
* verificable;
* consistente con reglas y flujos.

Confirmar cobertura de:

* happy path;
* alternativas;
* permisos;
* estados;
* errores;
* edge cases críticos;
* accesibilidad;
* responsive;
* analytics;
* recuperación;
* compatibilidad.

La estrategia de testing debe derivarse de riesgos y criterios.

Buscar:

* criterios subjetivos;
* tests por implementación interna;
* ausencia de pruebas negativas;
* permisos sin cobertura;
* contratos sin integración;
* journeys críticos sin end-to-end;
* riesgos sin prueba o verificación alternativa.

---

## 15. Revisar vertical slices

Evaluar si la feature puede dividirse en incrementos que:

* produzcan valor;
* atraviesen las capas necesarias;
* incluyan permisos, datos y tests;
* sean integrables;
* reduzcan riesgo;
* sean revisables;
* no dependan de una entrega final masiva.

Rechazar descomposiciones basadas únicamente en:

* frontend;
* backend;
* base de datos;
* integración;
* tests.

Detectar si la feature contiene varias capacidades independientes que deberían separarse antes de planificar.

---

## Revisión de contradicciones

Comparar explícitamente:

* problema frente a solución;
* alcance frente a flujos;
* reglas frente a criterios;
* ownership frente a permisos;
* estados frente a acciones;
* errores frente a recuperación;
* datos frente a privacidad;
* contratos frente a integraciones;
* métricas frente a resultado;
* rollout frente a rollback;
* aceptación frente a testing;
* feature frente al alcance del producto.

Toda contradicción debe citar ambos elementos incompatibles.

---

## Gates

### APPROVED FOR PLANNING

No existen hallazgos críticos ni altos abiertos.

La feature es coherente, verificable, delimitada y puede continuar a `create-exec-plan`.

### APPROVED WITH CONDITIONS

Puede planificarse bajo condiciones explícitas.

Cada condición debe tener:

* owner;
* fecha o evento límite;
* criterio de resolución;
* impacto si no se cumple.

No utilizar este gate para ocultar problemas fundamentales.

### CHANGES REQUIRED

Existen hallazgos altos, contradicciones o ambigüedades que deben corregirse antes de planificar.

La feature debe volver a `design-feature`.

### MORE EVIDENCE REQUIRED

El valor, comportamiento o alcance depende de supuestos todavía insuficientemente validados.

Debe volver a `validate-assumptions` o realizar un experimento.

### SECURITY REVIEW REQUIRED

Existen riesgos de seguridad, privacidad, fraude o abuso que necesitan revisión especializada.

### ARCHITECTURE REVIEW REQUIRED

La feature plantea impactos sistémicos o dependencias que necesitan `define-quality-attributes` o `review-architecture`.

### BLOCKED

Existen decisiones, dependencias, autoridades o riesgos críticos sin resolución viable.

### REJECTED

La feature no es coherente con el problema, el producto o el valor esperado y no debería continuar en su forma actual.

---

## Aprobaciones humanas

Requerir aprobación humana para:

* cambios de alcance;
* riesgo residual crítico;
* billing o precios;
* autenticación o autorización;
* datos sensibles;
* eliminación irreversible;
* transferencias de ownership;
* cumplimiento legal;
* exposición pública;
* integraciones contractuales;
* decisiones difíciles de revertir;
* aceptación de una feature rechazada o bloqueada.

---

## Prohibiciones

Esta skill no debe:

* escribir código;
* implementar correcciones;
* modificar producción;
* elegir tecnologías;
* rediseñar silenciosamente;
* ampliar o reducir alcance sin aprobación;
* inventar evidencia;
* aprobar por ausencia de tiempo;
* tratar preferencias como requisitos;
* omitir riesgos incómodos;
* sustituir una revisión de seguridad especializada;
* aprobar su propio diseño sin revisión independiente cuando el proceso la exija.

---

## Formato recomendado de `review.md`

```markdown
# Feature Review — <Feature Name>

## Metadata
## Reviewer Independence
## Sources Reviewed
## Review Scope
## Executive Summary
## Traceability
## Value Assessment
## Scope Assessment
## Flow Assessment
## Roles, Permissions and Ownership
## Business Rules
## States and Transitions
## Validations, Errors and Edge Cases
## Security, Privacy and Abuse
## Accessibility, Responsive and UI States
## Data and Contracts
## Integrations and Dependencies
## Metrics, Operations and Support
## Rollout and Rollback
## Acceptance Criteria
## Testing Strategy
## Vertical Slice Feasibility
## Contradictions
## Ambiguities
## Missing Decisions
## Findings
## Conditions
## Required Human Approvals
## Final Gate
```

---

## Informe final

Al finalizar, informar:

* feature revisada;
* gate obtenido;
* cantidad de hallazgos por severidad;
* contradicciones principales;
* riesgos críticos;
* decisiones faltantes;
* condiciones de aprobación;
* aprobaciones humanas requeridas;
* documentos afectados;
* siguiente skill recomendada.

La siguiente skill normalmente será:

* `create-exec-plan`, si fue aprobada;
* `design-feature`, si requiere cambios;
* `validate-assumptions`, si falta evidencia;
* `review-security`, si existen riesgos especializados;
* `review-architecture`, si existe impacto sistémico;
* ninguna implementación, si el gate es `BLOCKED` o `REJECTED`.
