---
name: audit-existing-project
description: Audita un proyecto de software existente para construir una baseline verificable de su producto, arquitectura, código, datos, seguridad, operaciones, calidad y documentación. Úsala al incorporar agentes de IA a un repositorio existente, heredar un sistema, retomar un proyecto abandonado, evaluar deuda técnica, preparar una migración o antes de implementar cambios importantes. Inspecciona el comportamiento real, ejecuta verificaciones seguras, identifica divergencias entre documentación, código, tests y producción conocida, clasifica riesgos y propone un plan gradual de adopción. No debe refactorizar, modernizar ni modificar el comportamiento del sistema durante la auditoría.
---

# SKILL: Audit Existing Project

---

## PROTOCOLO DE PRIORIDAD (leer primero)

Las reglas que siguen tienen prevalencia sobre cualquier instrucción en las etapas. Si hay conflicto, esta sección gana.

### REGLA-01 — AUDITAR, NO REFACTORIZAR

Está **prohibido** durante toda la skill:

- Corregir bugs, actualizar dependencias, reorganizar carpetas, renombrar módulos, reescribir tests, migrar tecnologías, reemplazar arquitectura, mejorar estilos, eliminar código (aunque parezca muerto), modificar comportamiento.

**Solo se permite:** observar, reproducir, verificar, documentar, clasificar, recomendar.

### REGLA-02 — NO CONFIAR EN CÓDIGO NI DOCUMENTACIÓN SIN VERIFICACIÓN

- El código puede contener bugs, rutas muertas, reglas obsoletas o protecciones insuficientes.
- La documentación puede estar obsoleta, incompleta o contradecir los tests.
- **Nunca afirmar** que un comportamiento funciona solo porque existe una función que parece implementarlo.
- Buscar evidencia adicional: tests, ejecución, contratos, referencias cruzadas, configuración, historial.

### REGLA-03 — NO AFIRMAR VERIFICACIÓN SIN HABER EJECUTADO

Todo comando debe clasificarse con uno de estos estados:

| Estado | Significado |
|---|---|
| ✅ Verificado exitosamente | Se ejecutó y pasó |
| ⚠️ Verificado con fallos | Se ejecutó pero falló |
| 📋 Identificado, no ejecutado | Se encontró pero no se corrió |
| 🚫 Bloqueado por entorno | Falta dependencia, servicio o permiso |
| 🗑️ Obsoleto | El comando ya no funciona o no aplica |
| ❓ Desconocido | No se sabe si existe |
| 🔒 Riesgoso, requiere aprobación | Podría afectar datos, producción o costos |

### REGLA-04 — NO JUZGAR POR PREFERENCIA

No clasificar como deuda solo porque el agente habría usado otra tecnología, patrón o estilo.

Una decisión es problemática **solo si produce impacto verificable** en: corrección, seguridad, mantenibilidad, rendimiento, escalabilidad, operación, experiencia, costo, velocidad o capacidad de prueba.

### REGLA-05 — PRIORIZAR RIESGO SOBRE ESTÉTICA

Orden de prioridad inamovible:

1. Pérdida o exposición de datos
2. Autenticación y autorización
3. Aislamiento entre tenants
4. Operaciones irreversibles
5. Fallos de despliegue
6. Integridad de datos
7. Ausencia de recuperación
8. Comportamiento incorrecto
9. Imposibilidad de validar cambios
10. Mantenibilidad
11. Consistencia
12. Estilo

### REGLA-06 — SEGURIDAD EN LA EJECUCIÓN

**Nunca ejecutar** comandos que: borren datos, modifiquen producción, publiquen paquetes, desplieguen, roten secretos, migren bases de datos compartidas, eliminen recursos, hagan force push, alteren ramas remotas, generen costos, contacten usuarios reales, envíen correos, ejecuten pagos o procesen webhooks reales.

### REGLA-07 — NO MOSTRAR SECRETOS EN EL INFORME

Si se detecta una credencial expuesta: registrar tipo, ubicación, severidad y acción requerida. **Redactar el valor.** Ejemplo:

> Se detectó una credencial aparentemente activa en `config/credentials.json`. El valor fue omitido deliberadamente. Acción: revocar, rotar, eliminar del historial.

### REGLA-08 — STOP CONDITIONS (detener ejecución, continuar documentación)

Detener acciones ejecutables inmediatamente cuando:

- Se detectan credenciales productivas expuestas
- No se puede asegurar que un comando no afecta producción
- Se encuentra migración destructiva conectada a datos compartidos
- El entorno local usa servicios reales sin aislamiento
- Un script requiere privilegios elevados
- Una prueba podría enviar pagos, emails o mensajes reales
- Se detecta posible compromiso de seguridad
- El repositorio contiene datos personales reales
- Un comando implica costo significativo

**Acción:** detener comando → conservar evidencia segura → ocultar datos sensibles → documentar riesgo → recomendar acción → continuar con áreas no afectadas.

---

## CLASIFICACIÓN DE EVIDENCIA (usar en todo hallazgo)

| Nivel | Nombre | Significado |
|---|---|---|
| E0 | Desconocido | No existe información suficiente |
| E1 | Inferido | Se deduce de nombres, estructura o patrones, no confirmado |
| E2 | Documentado | Existe documentación explícita, no verificada contra el sistema |
| E3 | Implementado | Existe código que aparentemente implementa el comportamiento |
| E4 | Probado | Existe un test que valida el comportamiento |
| E5 | Reproducido | El comportamiento fue ejecutado y observado en entorno controlado |
| E6 | Observado | Existe evidencia operacional confiable (métricas, logs, incidentes) |

**Regla:** Una afirmación de alta criticidad no se considera confirmada con evidencia E1 o E2.

---

## SEVERIDAD DE HALLAZGOS

| Nivel | Significado | Acción |
|---|---|---|
| **P0** — Emergencia | Secreto expuesto, datos públicos, pérdida activa, bypass de auth, tenants rotos, compromiso en curso | Detener trabajo normal inmediatamente |
| **P1** — Bloqueante | Autorización insuficiente, migración destructiva, sin backup, setup en producción, CI roto | Resolver antes de siguiente entrega |
| **P2** — Importante | Deuda estructural con impacto, observabilidad incompleta, tests parciales, docs obsoletas | Planificar en roadmap |
| **P3** — Mejora | Consistencia, automatización menor, docs secundarias, simplificaciones locales | Oportunístico |
| **P4** — Informativo | Contexto o recomendación sin riesgo inmediato | Registrar, no accionar |

---

## ÁRBOL DE DECISIÓN: QUÉ PROFUNDIDAD ELEGIR

```
¿Es primera vez que un agente toca este repo?
  ├── SÍ → ¿El proyecto es grande (monorepo, >5 servicios, >500 archivos fuente)?
  │         ├── SÍ → AUDITORÍA ESTÁNDAR con plan de profundización por capas
  │         └── NO → AUDITORÍA ESTÁNDAR completa
  └── NO → ¿Ya existe baseline parcial?
            ├── SÍ → AUDITORÍA FOCALIZADA sobre áreas no cubiertas
            └── NO → ¿Se necesita urgentemente?
                      ├── SÍ → AUDITORÍA RÁPIDA (setup + comandos + auth + riesgos P0/P1)
                      └── NO → AUDITORÍA PROFUNDA
```

---

## PLAN DE EJECUCIÓN SEGÚN PROFUNDIDAD

### Auditoría Rápida (quick)

Ejecutar **FASE 0 → FASE A → FASE B → FASE H** (ver matriz abajo). Tiempo objetivo: completar en una sesión.

**Entregable mínimo:** `docs/audit/audit-report.md` con: resumen ejecutivo, comandos verificados, baseline de auth/permisos, riesgos P0/P1, unknowns bloqueantes, plan de adopción inmediato.

### Auditoría Estándar (standard)

Ejecutar **FASE 0 → FASES A-G → FASE H**. Cubre todas las fases con profundidad proporcionada al tamaño del proyecto.

**Entregable:** estructura de archivos en `docs/audit/` según el tamaño del proyecto.

### Auditoría Profunda (deep)

Ejecutar **todas las fases** con profundidad máxima. Incluye: mapa de módulos detallado, revisión de contratos, migraciones históricas, Git hotspots, registros completos de deuda y riesgo.

### Auditoría Focalizada (focused)

Ejecutar **FASE 0 + solo las fases indicadas por el usuario** para el área específica.

---

## FASES DE AUDITORÍA

### FASE 0 — PREPARACIÓN Y CONTEXTO

**Objetivo:** Establecer el alcance y las restricciones sin modificar nada.

**Acciones obligatorias:**

1. Leer `AGENTS.md`, `README.md`, `docs/` disponibles.
2. Identificar rama actual. Confirmar que no es una rama protegida.
3. Revisar `git status`. Si hay cambios sin commit: **registrarlos, no modificarlos, aislarlos de la baseline.**
4. Clasificar el tipo de repositorio: aplicación única, monorepo, biblioteca, backend, frontend, sistema distribuido, infraestructura, mobile, plugin, datos/ML, embedded, multi-repo.
5. Seleccionar profundidad usando el árbol de decisión.
6. Registrar: rama, commit, alcance, limitaciones de entorno, fecha.

**Manejo de edge cases:**

| Escenario | Acción |
|---|---|
| Sin Git (repo nuevo, ZIP) | Documentar ausencia. Usar hash de contenidos como referencia. |
| CI/CD en repo separado | Registrar el repo externo como dependencia, documentar lo que sea visible. |
| Sin package manager (scripts sueltos) | Inventariar scripts manualmente, documentar ausencia de gestor. |
| Múltiples repositorios forman el producto | Auditar repo actual. Documentar dependencias cross-repo como integraciones externas. |

**Salida:** sección `Audit Scope` en el informe.

---

### FASE A — REPOSITORIO Y REPRODUCIBILIDAD

Agrupa: inventario del repositorio, comandos, entorno, dependencias, configuración y secretos.

#### A.1 Inventario estructural
- Archivos raíz, gestores de paquetes, workspaces, aplicaciones, paquetes, servicios, librerías, scripts, infraestructura, documentación, tests, fixtures, migraciones, schemas, artefactos generados, assets, configuraciones, workflows, tools.
- **No marcar como obsoleto sin evidencia.** No asumir que `legacy/` está fuera de uso.
- Identificar: lenguajes, frameworks, runtimes, package managers, build systems, format/lint/test frameworks, CI, contenedores, proveedores, bases de datos.
- Para sistemas sin package manager, inventariar scripts de build manuales.

#### A.2 Comandos verificables
- Buscar comandos en: `package.json`, `Makefile`, `Taskfile`, `justfile`, scripts, Docker Compose, docs, CI, configuración de IDE.
- Clasificar por tipo: install, dev, build, lint, format, typecheck, test (unit/integration/e2e), generate, migration, seed, deploy, smoke test, security.
- Ejecutar de forma segura (ver REGLA-06): install con lockfile, lint/format (modo check), typecheck, tests, build.
- **No ejecutar automáticamente:** seeds destructivos, migraciones contra DB compartida, deploy, publish, scripts con nombres `reset`, `clean`, `destroy`, `prod` sin inspección previa.

**Para cada comando, documentar:**

| Comando | Propósito | Estado | Resultado | Duración | Dependencias | Riesgo |
|---|---|---|---|---|---|---|

**Regla crítica para `AGENTS.md`:** no escribir comandos como válidos sin haberlos ejecutado o sin marcar explícitamente que no fueron verificados.

#### A.3 Reproducibilidad del entorno
Evaluar: versiones de runtime fijadas, lockfiles versionados, variables de entorno necesarias, servicios requeridos (DB, cache, queue, storage, emuladores), configuración local vs CI, diferencias por SO, herramientas del sistema, puertos, volúmenes, seeds, datos mínimos.

**Preguntas clave:**
- ¿La instalación es determinista?
- ¿Existen dependencias globales no documentadas?
- ¿Puede ejecutarse sin secretos productivos?
- ¿La base local es aislada?
- ¿Existe procedimiento de reset seguro?
- ¿Se puede crear un usuario de prueba?

**Salida:** guía de setup verificada.

#### A.4 Dependencias
Clasificar: runtime, desarrollo, build, testing, infraestructura, proveedor externo, interna, transitiva crítica.

Evaluar: versión, uso real, mantenimiento, licencia, vulnerabilidades conocidas, duplicación, APIs deprecated, riesgo de actualización, lockfile, código que replica una dependencia, dependencia sin abstracción.

**Cuidado:** un paquete listado pero no importado no es prueba de que no se usa (puede ser CLI, plugin, carga dinámica, peer dependency, build tool).

#### A.5 Configuración y secretos
Revisar: `.env.example`, `.env` rastreados, configuración por ambiente, CI secrets, Docker, infraestructura, credenciales, tokens, certificados, hardcodeos, URLs, CORS, cookies, headers, storage.

**Verificaciones:** secretos versionados, valores productivos en código, variables sin documentar, defaults inseguros, configuración inconsistente entre entornos, secretos expuestos al cliente, logging de secretos, datos reales en fixtures.

**Aplicar REGLA-07:** redactar cualquier valor sensible detectado.

---

### FASE B — PRODUCTO Y UX

**Objetivo:** Documentar qué producto existe realmente, contrastando documentación, código y comportamiento observable.

**Fuentes:** docs, rutas, pantallas, endpoints, modelos, tests, seeds, feature flags, navegación, permisos, integraciones, copy, analytics, facturación, onboarding.

**Distinguir explícitamente:**

| Tipo | Definición |
|---|---|
| Comportamiento esperado | Lo que el negocio cree que hace |
| Comportamiento documentado | Lo que la documentación dice que hace |
| Comportamiento implementado | Lo que el código parece hacer |
| Comportamiento probado | Lo que los tests validan |
| Comportamiento reproducido | Lo que se observó al ejecutar |
| Divergencias | Diferencias entre los anteriores |

**Identificar:** actores, roles, capacidades, flujos principales, entidades, reglas, estados, límites, monetización, funcionalidades incompletas/ocultas/abandonadas, flags, operaciones administrativas.

**Señales de divergencia:** pantalla sin endpoint, endpoint sin consumidor, modelo sin uso, tests para comportamiento no documentado, feature flag permanente, copy que promete algo no implementado, docs con módulos inexistentes, migraciones de funcionalidades eliminadas, múltiples implementaciones del mismo flujo.

**No reconstruir el producto exclusivamente desde nombres de archivos.**

---

### FASE C — ARQUITECTURA

**Objetivo:** Representar la arquitectura tal como existe.

**Documentar:** contexto, aplicaciones, servicios, paquetes, módulos, boundaries, dependencias, flujos de datos, procesos síncronos/asíncronos, almacenamiento, integraciones, infraestructura, puntos de entrada.

**Para cada componente crítico:**

- Responsabilidad
- Interfaces públicas
- Dependencias
- Datos que posee
- Sistemas externos
- Runtime
- Impacto de fallo
- Tests
- Observabilidad
- Evidencia (nivel E0-E6)
- Unknowns

**Detectar:** dependencias circulares, módulos con demasiadas responsabilidades, reglas de negocio en UI, reglas duplicadas, acoplamiento a infraestructura, acceso transversal a base de datos, contratos implícitos, utilidades globales sin ownership, componentes críticos sin tests, fronteras que solo existen en carpetas.

**No recomendar microservicios** solo porque un módulo es grande. Evaluar primero: cohesión, acoplamiento, frecuencia de cambio, ownership, escalabilidad independiente, aislamiento de fallos, complejidad operacional.

---

### FASE D — DATOS, MIGRACIONES Y PERSISTENCIA

#### D.1 Modelo de datos
Revisar: schemas, modelos, migraciones, constraints, índices, relaciones, enums, triggers, views, políticas, seeds, repositorios, consultas, transacciones, archivos, caches, búsquedas, datos derivados, almacenamiento externo.

**Documentar:** data stores, entidades principales, ownership, relaciones, constraints, ciclo de vida, retención, campos sensibles, datos derivados, búsqueda/indexado, backups, procedimiento de restore, riesgos conocidos.

**Evaluar:** PKs, FKs, unique constraints, nullability, defaults, estados, timestamps, soft/hard delete, cascades, tenant keys, auditoría, consistencia, idempotencia, concurrencia, transacciones, integridad referencial, zonas horarias, moneda, precisión decimal, datos personales, archivos huérfanos.

**Preguntas críticas:** ¿Qué datos pertenecen a cada tenant? ¿Cómo se evita acceso cruzado? ¿Existe ownership explícito? ¿Qué ocurre al eliminar una cuenta? ¿Se puede restaurar? ¿Los backups se prueban?

#### D.2 Migraciones
Evaluar: orden, consistencia, migraciones faltantes, migraciones editadas post-aplicación, diferencias schema vs migraciones, operaciones destructivas, renames, backfills, defaults, locks, tiempos, rollback, compatibilidad, seeds dependientes.

**Clasificar cada migración riesgosa:** aditiva, compatible, potencialmente bloqueante, destructiva, irreversible, dependiente de datos, dependiente de código, desconocida.

**Buscar:** `DROP`, cambios de tipo, eliminación de constraints, `NOT NULL` sin backfill, índices grandes, reescrituras de tabla, migraciones que mezclan schema y negocio, scripts manuales no versionados.

**No aplicar migraciones durante la auditoría** salvo en base efímera creada específicamente para validación y con aprobación explícita.

---

### FASE E — SEGURIDAD, IDENTIDAD Y AISLAMIENTO

#### E.1 Autenticación
Revisar: registro, login, logout, sesiones, refresh, cookies, tokens, proveedores externos (OAuth, SAML, SSO), recuperación, verificación, MFA, cambio de email/contraseña, revocación, expiración, suplantación, cuentas de servicio.

**Evaluar:** sesiones demasiado largas, tokens en almacenamiento inseguro, cookies sin flags (`HttpOnly`, `Secure`, `SameSite`), recuperación débil, falta de revocación, enumeración de usuarios, login CSRF, open redirects, credenciales compartidas, bypasses de desarrollo, entornos que comparten identidad.

#### E.2 Autorización
Revisar autorización en: UI, middleware, rutas, controladores, servicios, repositorios, base de datos, storage, jobs, webhooks, administración, exportaciones, archivos.

**Preguntas clave:**
- ¿La UI oculta o realmente impide?
- ¿La autorización se verifica siempre del lado servidor?
- ¿Los recursos se cargan con scope de tenant?
- ¿Se valida ownership en cada operación?
- ¿Los IDs son adivinables?
- ¿Los jobs revalidan permisos?
- ¿Los webhooks pueden modificar cualquier cuenta?
- ¿La revocación es inmediata?
- ¿Existen permisos implícitos por nombre de rol?

**Producir matriz:** Recurso × Acción × Actor × Control UI × Control servidor × Control datos × Test.

**Hallazgo crítico:** ocultar un botón no equivale a autorización.

#### E.3 Multitenancy
Identificar modelo: base separada, schema separado, tablas compartidas con tenant key, row-level security, aislamiento por servicio, combinación.

**Revisar:** resolución de tenant, cambio de contexto, consultas, caches, storage, jobs, colas, búsquedas, exports, logs, analytics, webhooks, administración, invitaciones, transferencias, eliminación, backups.

**Clasificar aislamiento:** verificado, parcial, implícito, no verificado, riesgo crítico.

#### E.4 Seguridad general (revisión de baseline)
Superficies: autenticación, autorización, sesiones, datos, APIs, uploads, webhooks, dependencias, configuración, secretos, frontend, SSR, administración, infraestructura, CI, logs, jobs.

**Revisar:** validación de input, output encoding, inyección (SQL, NoSQL, command), XSS, CSRF, SSRF, path traversal, file uploads, deserialización, open redirects, rate limiting, brute force, enumeración, replay, IDOR, escalación de privilegios, tenant isolation, exposición de errores, secretos, permisos cloud, supply chain.

**No ejecutar exploits destructivos.** Las pruebas deben ser seguras y limitadas al entorno autorizado.

---

### FASE F — APIS, INTEGRACIONES Y PROCESOS ASÍNCRONOS

#### F.1 APIs y contratos
Incluir: REST, GraphQL, RPC, server actions, webhooks, eventos, colas, archivos, SDK, contratos entre paquetes, APIs internas, interfaces frontend.

**Para cada contrato:** consumer, provider, auth, input/output, errores, versionado, idempotencia, rate limiting, compatibilidad, tests, evidencia.

**Detectar:** contratos implícitos, respuestas inconsistentes, errores que filtran detalles internos, endpoints sin autorización, endpoints no utilizados, consumidores desconocidos, payloads excesivos, duplicación de validación.

#### F.2 Integraciones externas
Identificar: pagos, emails, SMS, auth providers, storage, mapas, analytics, búsqueda, IA, CRM, ERP, webhooks entrantes/salientes, APIs públicas, servicios internos, proveedores cloud.

**Para cada integración:** propósito, proveedor, dirección (inbound/outbound/bidirectional), credenciales, datos intercambiados, datos sensibles, asunciones de disponibilidad, timeout, retry, idempotencia, rate limits, comportamiento ante fallo, conciliación, sandbox, monitoreo, ownership, estrategia de salida.

**Preguntas clave:** ¿Qué pasa si el proveedor está caído? ¿Se reintenta idempotentemente? ¿Hay conciliación? ¿Se verifican firmas? ¿Existe replay protection? ¿Se registran payloads sensibles? ¿Los tests llaman servicios reales? ¿Existe lock-in?

#### F.3 Procesos asíncronos
Revisar: cron, workers, queues, retries, dead letters, schedulers, eventos de dominio, eventos de integración, webhooks, procesamiento de archivos, notificaciones.

**Evaluar:** idempotencia, reintentos con backoff, duplicados, ordering, locks, concurrencia, timeouts, poison messages, observabilidad, recuperación, cancelación, despliegues, versionado de payloads.

**Hallazgos frecuentes:** job sin límite de reintentos, efectos no idempotentes, cron ejecutado por múltiples instancias, eventos sin versionado, errores silenciosos, cola sin dead-letter, payloads con datos sensibles.

---

### FASE G — CALIDAD, CI/CD Y OPERACIONES

#### G.1 Testing
Inventariar: unitarios, integración, contrato, e2e, visuales, accesibilidad, rendimiento, seguridad, migraciones, smoke, snapshots, tests manuales documentados.

**Evaluar:** qué comportamientos cubren, qué criticidades no cubren, estabilidad, aislamiento, fixtures, mocks, velocidad, flakiness, dependencias externas, calidad de assertions, falsos positivos, tests deshabilitados, cobertura significativa (no solo % de líneas).

**Preguntas:** ¿Los tests pueden fallar por la razón correcta? ¿Prueban comportamiento o implementación? ¿Se prueban permisos y acceso cruzado? ¿Se prueban migraciones? ¿Se prueban errores y reintentos? ¿El e2e puede ejecutarse localmente?

**Clasificar áreas:** bien protegida, parcialmente protegida, cobertura superficial, no protegida, desconocida.

#### G.2 Build y CI
Revisar build: compilación, bundling, generación de clientes/tipos, codegen, contenedores, artefactos, assets, cachés, build limpio, determinismo.

Revisar CI: triggers, permisos, jobs, matrices, caching, secrets, artifacts, conditions, branches, environments, approvals, timeouts, concurrency, required checks.

**Riesgos frecuentes:** CI verde sin ejecutar tests relevantes, jobs opcionales, checks no requeridos, permisos excesivos, secretos disponibles en PRs de forks, deploy automático sin gate, `continue-on-error` ocultando fallos.

#### G.3 Despliegue y release
Documentar: entornos, proveedor, artefactos, pipeline, responsables, aprobaciones, migraciones, feature flags, smoke tests, rollback, rollforward, versionado, changelog, monitoreo post-deploy.

**Clasificar:** automatizado y verificado, automatizado parcialmente, manual documentado, manual no documentado, desconocido, riesgoso.

#### G.4 Observabilidad
Evaluar: logs, métricas, traces, error tracking, health checks, dashboards, alertas, auditoría, correlation IDs, structured logging, retención, redacción de datos sensibles, ownership, runbooks.

**Hallazgos críticos:** secretos en logs, datos personales sin redactar, errores silenciosos, ausencia total de monitoreo, alertas sin responsable, logs imposibles de correlacionar, falta de auditoría en acciones administrativas.

#### G.5 Operación y soporte
Revisar: panel administrativo, herramientas internas, runbooks, soporte, recuperación de cuentas, corrección de datos, moderación, conciliación, exportación, eliminación, disputas, fraude, incidentes, mantenimiento.

**Identificar:** operaciones peligrosas en scripts informales, conocimiento que reside en una sola persona, tareas manuales sin documentar.

---

### FASE H — CONSOLIDACIÓN Y PLAN

#### H.1 Deuda técnica
Registrar deuda con **impacto concreto**, no con etiquetas vagas ("código feo", "arquitectura mala").

Para cada item: categoría, evidencia, impacto actual, impacto futuro, probabilidad, severidad, esfuerzo estimado (XS-XL), remediación, dependencias, riesgo de remediación, timing sugerido.

#### H.2 Deuda de producto
Detectar: flujo incompleto, copy incorrecto, permisos incoherentes, funcionalidad sin usuario claro, proceso administrativo ausente, estado no representado, feature sin métricas, onboarding bloqueado, promesa no implementada, acciones sin recuperación.

#### H.3 Registro de riesgos
Categorías: producto, seguridad, privacidad, datos, arquitectura, operación, disponibilidad, integraciones, dependencia, rendimiento, escalabilidad, testing, despliegue, cumplimiento, conocimiento.

**Para cada riesgo:** descripción, evidencia, probabilidad, impacto, detectabilidad, controles actuales, controles faltantes, mitigación, contingencia.

#### H.4 Unknowns
Registrar explícitamente lo que no se sabe. Categorizar como: producto, usuarios, datos, producción, seguridad, costos, volumen, integraciones, infraestructura, operación, cumplimiento, ownership.

**"Desconocido" es un resultado válido.** No reemplazar desconocimiento con confianza falsa.

#### H.5 Preparación para agentes (Nivel 0-5)

| Nivel | Descripción | Requisitos mínimos |
|---|---|---|
| 0 — No preparado | Sin comandos, tests ni aislamiento | — |
| 1 — Exploración | Solo lectura y documentación | Acceso al repo |
| 2 — Cambios supervisados | Tareas pequeñas con revisión | Setup reproducible, checks básicos |
| 3 — Autonomía en ramas | Implementación con PR | Tests, CI, instrucciones, worktrees |
| 4 — Autonomía operativa | Previews, smoke tests, rollback | Observabilidad, staging, gates humanos |
| 5 — Alta automatización | Procesos maduros | Validaciones, releases progresivos, respuesta a incidentes |

#### H.6 Plan gradual de adopción (Fases A-F)

- **Fase A — Seguridad básica:** eliminar secretos expuestos, proteger ramas, documentar comandos, evitar acceso productivo.
- **Fase B — Reproducibilidad:** fijar runtimes, aislar entorno, `.env.example`, datos de prueba.
- **Fase C — Verificación:** lint, typecheck, build, estabilizar tests, CI, smoke tests.
- **Fase D — Fuente de verdad:** `AGENTS.md`, `project-status.md`, arquitectura baseline, ADRs.
- **Fase E — Trabajo con agentes:** ramas, tareas pequeñas, vertical slices, PR, revisión independiente.
- **Fase F — Madurez operativa:** observabilidad, staging, rollback, migraciones seguras, feature flags, runbooks.

#### H.7 Resultado de auditoría

| Resultado | Cuándo usarlo |
|---|---|
| **BASELINE ESTABLISHED** | Setup funciona (o limitaciones claras), comandos identificados, arquitectura mapeada, riesgos críticos identificados, unknowns registrados, plan de adopción existe. |
| **PARTIAL BASELINE** | Áreas verificadas parcialmente, limitaciones de acceso, faltan entornos, unknowns importantes, se puede avanzar en áreas limitadas. Especificar qué áreas son seguras. |
| **BLOCKED** | No se puede inspeccionar, setup imposible sin información, secretos expuestos requieren acción inmediata, riesgo de afectar producción, datos podrían perderse, evidencia de compromiso. |

Antes de marcar `BLOCKED`, completar toda inspección segura posible.

#### H.8 Documentación final

**`AGENTS.md`** — Incluir solo: propósito breve, fuentes de verdad, estructura relevante, comandos comprobados, workflow, restricciones, aprobaciones requeridas, definición de terminado, reglas de seguridad. **No incluir:** teorías, comandos no verificados, secretos, preferencias sin impacto.

**`docs/project-status.md`** — Formato:

```markdown
# Project Status
## Current phase — Existing project baseline
## Audit status — Complete | Partial | Blocked
## Verified commands
## Critical risks
## Critical unknowns
## Blocking remediation
## Agent readiness level
## Recommended next action
## Recommended skill
```

**Estructura de archivos de auditoría:**

```
Proyecto pequeño → docs/audit/audit-report.md
Proyecto mediano → docs/audit/{executive-summary, product-baseline, architecture-baseline, 
                   data-baseline, security-baseline, testing-baseline, risk-register, adoption-plan}.md
Monorepo/grande  → docs/audit/index.md + sub-auditorías por componente/aplicación
```

---

## FORMATO DE HALLAZGOS (usar consistemente)

```markdown
## [P1] Título del hallazgo

### Área
Security | Data | Architecture | Testing | Operations | Product

### Descripción
Qué ocurre.

### Evidencia
- Componente/archivo:
- Referencia:
- Comando ejecutado (si aplica):
- Resultado:
- Nivel de evidencia: E0-E6
- Confianza: Alta | Media | Baja

### Impacto
Qué podría ocurrir y a quién afecta.

### Escenario
Cómo se manifiesta.

### Recomendación
Qué debería hacerse.

### Timing
Immediate | Before next change | Planned | Opportunistic
```

---

## FORMATO DEL RESUMEN EJECUTIVO (informe al usuario)

```markdown
# Audit Existing Project — Resultado

## Estado
BASELINE ESTABLISHED | PARTIAL BASELINE | BLOCKED

## Resumen
Conclusión principal en 2-3 frases.

## Nivel de preparación para agentes
Nivel X — descripción breve.

## Hallazgos críticos (P0/P1)
1. [P0] ...
2. [P1] ...

## Verificaciones ejecutadas
- ✅ comando: resultado
- ⚠️ comando: resultado con fallos
- 📋 comando: identificado, no ejecutado (razón)

## Áreas no verificadas
1. Área — razón
2. Área — razón

## Documentos creados o actualizados
- `ruta`
- `ruta`

## Acciones inmediatas
1. ...
2. ...

## Siguiente etapa recomendada
Descripción y skill recomendada (`nombre-de-skill`).
```

**No incluir:** secretos, tokens, datos personales, payloads sensibles.

---

## CÓMO INVOCAR ESTA SKILL

### Auditoría estándar (recomendada para primer contacto)

```text
Ejecuta la skill audit-existing-project sobre este repositorio en modo estándar.

Lee primero AGENTS.md, README.md, docs/ y configuración del proyecto.

No refactorices, no actualices dependencias, no modifiques comportamiento,
no apliques migraciones, no accedas a producción.

Ejecuta verificaciones locales seguras y actualiza documentación.

Distingue explícitamente: documentado, implementado, probado, reproducido,
inferido y desconocido.

Al finalizar, actualiza docs/project-status.md y entrega un plan gradual.
```

### Auditoría rápida

```text
Ejecuta audit-existing-project en modo rápido.

Prioriza: setup, comandos, arquitectura, datos, auth/permisos, tests,
riesgos P0/P1, preparación para agentes.

No modifiques código.
```

### Auditoría profunda

```text
Ejecuta audit-existing-project en modo profundo.

Incluye: mapa de módulos, contratos, migraciones, multitenancy,
integraciones, procesos asíncronos, CI/CD, observabilidad, seguridad,
privacidad, operación, Git hotspots, registros completos de riesgos y deuda.

No realices remediaciones.
```

### Auditoría focalizada

```text
Ejecuta audit-existing-project únicamente sobre [área o módulo].

Evalúa dependencias y efectos transversales, pero no amplíes al resto
del repositorio salvo riesgo directo.
```

---

## REGLA FINAL

La auditoría debe dejar el proyecto **más comprensible y más seguro para modificar**, sin convertir la fase de descubrimiento en una refactorización encubierta.

El resultado correcto **no es:** "El proyecto debería reescribirse."

El resultado correcto **es:** "Este es el sistema que existe, esta es la evidencia disponible, estos son sus riesgos, estas áreas pueden modificarse de forma segura y este es el camino incremental para mejorar lo demás."
